namespace Elastica;

/**
 * Client to connect the the elasticsearch server
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Client
{
    /**
     * Config with defaults
     *
     * log: Set to true, to enable logging, set a string to log to a specific file
     * retryOnConflict: Use in \Elastica\Client::updateDocument
     *
     * @var array
     */
    protected _config;

    /**
     * @var \Elastica\Connection[] List of connections
     */
    protected _connections = [];

    /**
     * @var callback
     */
    protected _callback = null;

    /**
     * @var \Elastica\Request
     */
    protected _lastRequest;

    /**
     * @var \Elastica\Response
     */
    protected _lastResponse;

    /**
     * @var LoggerInterface
     */
    protected _logger = null;

    /**
     * Creates a new Elastica client
     *
     * @param array    config   OPTIONAL Additional config options
     * @param callback callback OPTIONAL Callback function which can be used to be notified about errors (for example connection down)
     */
    public function __construct(var config = null, var callback = null)
    {
        var conf;
        let conf = [
            "host": null,
            "port": null,
            "path": null,
            "url": null,
            "proxy": null,
            "transport": null,
            "persistent": true,
            "timeout": null,
            "connections": [], // host, port, path, timeout, transport, persistent, timeout, config -> (curl, headers, url)
            "roundRobin": false,
            "log": false,
            "retryOnConflict": 0
        ];

        if (config === null) {
            let config = conf;
        }

        this->setConfig(config);
        let this->_callback = callback;
        this->_initConnections();
    }

    /**
     * Inits the client connections
     */
    protected function _initConnections()
    {
        var connection, connections, server, servers;
        let connections = this->getConfig("connections");

        for connection in connections {
            let this->_connections[] = Connection::create(this->_prepareConnectionParams(connection));
        }

        if isset this->_config["servers"] {
            let servers = this->getConfig("servers");
            for server in servers {
                let this->_connections[] = Connection::create(this->_prepareConnectionParams(server));
            }
        }

        // If no connections set, create default connection
        if empty this->_connections {
            let this->_connections[] = Connection::create(this->_prepareConnectionParams(this->getConfig()));
        }
    }

    /**
     * Creates a Connection params array from a Client or server config array.
     *
     * @param array config
     * @return array
     */
    protected function _prepareConnectionParams(var config) -> array
    {
        var params, key, value;
        let params = [];
        let params["config"] = [];
        for key, value in config {
            if in_array(key, ["curl", "headers", "url"]) {
                let params["config"][key] = value;
            } else {
                let params[key] = value;
            }
        }

        return params;
    }

    /**
     * Sets specific config values (updates and keeps default values)
     *
     * @param  array           config Params
     * @return \Elastica\Client
     */
    public function setConfig(var config) -> <\Elastica\Client>
    {
        var key, value;

        for key, value in config {
            let this->_config[key] = value;
        }

        return this;
    }

    /**
     * Returns a specific config key or the whole
     * config array if not set
     *
     * @param  string                              key Config key
     * @throws \Elastica\Exception\InvalidException
     * @return array|string                        Config value
     */
    public function getConfig(string key = "") -> array | string
    {
        if empty key {
            return this->_config;
        }

        if !array_key_exists(key, this->_config) {
            throw new \Elastica\Exception\InvalidException("Config key is not set: " . key);
        }

        return this->_config[key];
    }

    /**
     * Sets / overwrites a specific config value
     *
     * @param  string          key   Key to set
     * @param  mixed           value Value
     * @return \Elastica\Client Client object
     */
    public function setConfigValue(string key, var value) -> <\Elastica\Client>
    {
        return this->setConfig([key: value]);
    }

    /**
     * @param array|string keys config key or path of config keys
     * @param mixed def default value will be returned if key was not found
     * @return mixed
     */
    public function getConfigValue(var keys, var def = null)
    {
        var key, value;
        let value = this->_config;
        for key in keys {
            if isset value[key] {
                let value = value[key];
            } else {
                return def;
            }
        }
        return value;
    }

    /**
     * Returns the index for the given connection
     *
     * @param  string         name Index name to create connection to
     * @return \Elastica\Index Index for the given name
     */
    public function getIndex(string name) -> <\Elastica\Index>
    {
        return new \Elastica\Index(this, name);
    }

    /**
     * Adds a HTTP Header
     *
     * @param  string                              header      The HTTP Header
     * @param  string                              headerValue The HTTP Header Value
     * @throws \Elastica\Exception\InvalidException If header or headerValue is not a string
     */
    public function addHeader(string header, string headerValue)
    {
        if typeof header == "string" && typeof headerValue == "string" {
            let this->_config["headers"][header] = headerValue;
        } else {
            throw new \Elastica\Exception\InvalidException("Header must be a string");
        }
    }

    /**
     * Remove a HTTP Header
     *
     * @param  string                              header The HTTP Header to remove
     * @throws \Elastica\Exception\InvalidException IF header is not a string
     */
    public function removeHeader(string header)
    {
        if typeof header == "string" {
            if (array_key_exists(header, this->_config["headers"])) {
                unset(this->_config["headers"][header]);
            }
        } else {
            throw new \Elastica\Exception\InvalidException("Header must be a string");
        }
    }

    /**
     * Uses _bulk to send documents to the server
     *
     * Array of \Elastica\Document as input. Index and type has to be
     * set inside the document, because for bulk settings documents,
     * documents can belong to any type and index
     *
     * @param  array|\Elastica\Document[]           docs Array of Elastica\Document
     * @return \Elastica\Bulk\ResponseSet                   Response object
     * @throws \Elastica\Exception\InvalidException If docs is empty
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function updateDocuments(var docs) -> <\Elastica\Bulk\ResponseSet>
    {
        var bulk;

        if empty docs {
            throw new \Elastica\Exception\InvalidException("Array has to consist of at least one element");
        }

        let bulk = new \Elastica\Bulk(this);

        bulk->addDocuments(docs, \Elastica\Bulk\Action::OP_TYPE_UPDATE);

        return bulk->send();
    }

    /**
     * Uses _bulk to send documents to the server
     *
     * Array of \Elastica\Document as input. Index and type has to be
     * set inside the document, because for bulk settings documents,
     * documents can belong to any type and index
     *
     * @param  array|\Elastica\Document[]           docs Array of Elastica\Document
     * @return \Elastica\Bulk\ResponseSet                   Response object
     * @throws \Elastica\Exception\InvalidException If docs is empty
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function addDocuments(var docs) -> <\Elastica\Bulk\ResponseSet>
    {
        var bulk;

        if empty docs {
            throw new \Elastica\Exception\InvalidException("Array has to consist of at least one element");
        }

        let bulk = new \Elastica\Bulk(this);

        bulk->addDocuments(docs);

        return bulk->send();
    }

    /**
     * Update document, using update script. Requires elasticsearch >= 0.19.0
     *
     * @param  int                  id      document id
     * @param  array|\Elastica\Script|\Elastica\Document data    raw data for request body
     * @param  string               index   index to update
     * @param  string               type    type of index to update
     * @param  array                options array of query params to use for query. For possible options check es api
     * @return \Elastica\Response
     * @link http://www.elasticsearch.org/guide/reference/api/update.html
     */
    public function updateDocument(
        var id,
        var data,
        string index,
        string type,
        var options = []
    ) -> <\Elastica\Response>
    {
        var path, requestData, responseData, docOptions, retryOnConflict, response;

        let path =  index . "/" . type . "/" . id . "/_update";

        if data instanceof \Elastica\Script {
            let requestData = data->toArray();
        } else {
            if data instanceof \Elastica\Document {

                let requestData["doc"] = data->getData();

                if data->getDocAsUpsert() {
                    let requestData["doc_as_upsert"] = true;
                }

                let docOptions = data->getOptions(
                    [
                        "version",
                        "version_type",
                        "routing",
                        "percolate",
                        "parent",
                        "fields",
                        "retry_on_conflict",
                        "consistency",
                        "replication",
                        "refresh",
                        "timeout"
                    ]
                );
                let options += docOptions;
                // set fields param to source only if options was not set before
                if (data instanceof \Elastica\Document) && data->isAutoPopulate()
                    || this->getConfigValue([
                            "document",
                            "autoPopulate"
                        ], false)
                    && !isset options["fields"]
                {
                    let options["fields"] = "_source";
                }
            } else {
                let requestData = data;
            }
        }

        //If an upsert document exists
        if (data instanceof \Elastica\Script) || (data instanceof \Elastica\Document) {

            if data->hasUpsert() {
                let requestData["upsert"] = data->getUpsert()->getData();
            }
        }

        if !isset options["retry_on_conflict"] {
            let retryOnConflict = this->getConfig("retryOnConflict");
            let options["retry_on_conflict"] = retryOnConflict;
        }

        let response = this->request(path, \Elastica\Request::POST, requestData, options);

        if response->isOk()
            && (data instanceof \Elastica\Document)
            && (data->isAutoPopulate() || this->getConfigValue(["document", "autoPopulate"], false))
        {
            let responseData = response->getData();
            if isset responseData["_version"] {
                data->setVersion(responseData["_version"]);
            }
            if isset options["fields"] {
                this->_populateDocumentFieldsFromResponse(response, data, options["fields"]);
            }
        }

        return response;
    }

    /**
     * @param \Elastica\Response response
     * @param \Elastica\Document document
     * @param string fields Array of field names to be populated or "_source" if whole document data should be updated
     */
    protected function _populateDocumentFieldsFromResponse(
        <\Elastica\Response> response,
        <\Elastica\Document> document,
        var fields
    )
    {
        var responseData, key, keys, data;

        let responseData = response->getData();
        if fields ==  "_source" {
            if isset responseData["get"]["_source"] && typeof responseData["get"]["_source"] == "array" {
                document->setData(responseData["get"]["_source"]);
            }
        } else {
            let keys = explode(",", fields);
            let data = document->getData();
            for key in keys {
                if isset responseData["get"]["fields"][key] {
                    let data[key] = responseData["get"]["fields"][key];
                } else {
                    if isset data[key] {
                        unset(data[key]);
                    }
                }
            }
            document->setData(data);
        }
    }

    /**
     * Bulk deletes documents
     *
     * @param array|\Elastica\Document[] docs
     * @return \Elastica\Bulk\ResponseSet
     * @throws \Elastica\Exception\InvalidException
     */
    public function deleteDocuments(var docs) -> <\Elastica\Bulk\ResponseSet>
    {
        if empty docs {
            throw new \Elastica\Exception\InvalidException("Array has to consist of at least one element");
        }

        var bulk;
        let bulk = new \Elastica\Bulk(this);
        bulk->addDocuments(docs, \Elastica\Bulk\Action::OP_TYPE_DELETE);

        return bulk->send();
    }

    /**
     * Returns the status object for all indices
     *
     * @return \Elastica\Status Status object
     */
    public function getStatus() -> <\Elastica\Status>
    {
        return new \Elastica\Status(this);
    }

    /**
     * Returns the current cluster
     *
     * @return \Elastica\Cluster Cluster object
     */
    public function getCluster() -> <\Elastica\Cluster>
    {
        return new \Elastica\Cluster(this);
    }

    /**
     * @param  \Elastica\Connection connection
     * @return \Elastica\Client
     */
    public function addConnection(<\Elastica\Connection> connection) -> <\Elastica\Client>
    {
        let this->_connections[] = connection;

        return this;
    }

    /**
     * Determines whether a valid connection is available for use.
     *
     * @return bool
     */
    public function hasConnection() -> boolean
    {
        var connection, connections;
        let connections = this->_connections;
        for connection in connections {
            if connection->isEnabled() {
                return true;
            }
        }

        return false;
    }

    /**
     * @throws \Elastica\Exception\ClientException
     * @return \Elastica\Connection
     */
    public function getConnection()
    {
        var enabledConnection, connection, connections;

        let enabledConnection = null;
        let connections = this->_connections;
        for connection in connections {
            if connection->isEnabled() {
                let enabledConnection = connection;
                break;
            }
        }

        if empty enabledConnection {
            throw new \Elastica\Exception\ClientException("No enabled connection");
        }

        return enabledConnection;
    }

    /**
     * @return \Elastica\Connection[]
     */
    public function getConnections()
    {
        return this->_connections;
    }

    /**
     * @param  \Elastica\Connection[] connections
     * @return \Elastica\Client
     */
    public function setConnections(var connections) -> <\Elastica\Client>
    {
        let this->_connections = connections;

        return this;
    }

    /**
     * Deletes documents with the given ids, index, type from the index
     *
     * @param  array                               ids   Document ids
     * @param  string|\Elastica\Index               index Index name
     * @param  string|\Elastica\Type                type  Type of documents
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Bulk\ResponseSet                   Response object
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function deleteIds(var ids, var index, var type) -> <\Elastica\Bulk\ResponseSet>
    {
        var id, bulk, action;

        if empty ids {
            throw new \Elastica\Exception\InvalidException("Array has to consist of at least one id");
        }

        let bulk = new \Elastica\Bulk(this);
        bulk->setIndex(index);
        bulk->setType(type);

        for id in ids {
            let action = new \Elastica\Bulk\Action(\Elastica\Bulk\Action::OP_TYPE_DELETE);
            action->setId(id);

            bulk->addAction(action);
        }

        return bulk->send();
    }

    /**
     * Bulk operation
     *
     * Every entry in the params array has to exactly on array
     * of the bulk operation. An example param array would be:
     *
     * array(
     *         array("index" => array("_index" => "test", "_type" => "user", "_id" => "1")),
     *         array("user" => array("name" => "hans")),
     *         array("delete" => array("_index" => "test", "_type" => "user", "_id" => "2"))
     * );
     *
     * @param  array                                    params Parameter array
     * @throws \Elastica\Exception\ResponseException
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Bulk\ResponseSet                        Response object
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function bulk(var params) -> <\Elastica\Bulk\ResponseSet>
    {
        var bulk;

        if empty params {
            throw new \Elastica\Exception\InvalidException("Array has to consist of at least one param");
        }

        let bulk = new \Elastica\Bulk(this);

        bulk->addRawData(params);

        return bulk->send();
    }

    /**
     * Makes calls to the elasticsearch server based on this index
     *
     * It"s possible to make any REST query directly over this method
     *
     * @param  string            path   Path to call
     * @param  string            method Rest method to use (GET, POST, DELETE, PUT)
     * @param  array             data   OPTIONAL Arguments as array
     * @param  array             query  OPTIONAL Query params
     * @throws Exception\ConnectionException|\Exception
     * @return \Elastica\Response Response object
     */
    public function request(string path, var method = null, var data = [], var query = [])
    {
        var connection, request, response, e;

        if method == null {
            let method = \Elastica\Request::GET;
        }

        let connection = this->getConnection();
        try {
            let request = new \Elastica\Request(path, method, data, query, connection);

            this->_log(request);

            let response = request->send();

            let this->_lastRequest = request;
            let this->_lastResponse = response;

            return response;

        } catch \Elastica\Exception\ConnectionException, e {
            connection->setEnabled(false);

            // Calls callback with connection as param to make it possible to persist invalid connections
            if (this->_callback) {
                call_user_func(this->_callback, connection, e, this);
            }

            // In case there is no valid connection left, throw exception which caused the disabling of the connection.
            if (!this->hasConnection()) {
                throw e;
            }
            return this->request(path, method, data, query);
        }
    }

    /**
     * Optimizes all search indices
     *
     * @param  array             args OPTIONAL Optional arguments
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-optimize.html
     */
    public function optimizeAll(var args = []) -> <\Elastica\Response>
    {
        return this->request("_optimize", \Elastica\Request::POST, [], args);
    }

    /**
     * Refreshes all search indices
     *
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-refresh.html
     */
    public function refreshAll() -> <\Elastica\Response>
    {
        return this->request("_refresh", \Elastica\Request::POST);
    }

    /**
     * logging
     *
     * @param string|\Elastica\Request context
     * @throws Exception\RuntimeException
     */
    protected function _log(var context) -> void
    {
        var log, data = [];
        let log = this->getConfig("log");

        if log && !class_exists("Psr\Log\AbstractLogger") {
            throw new \Elastica\Exception\RuntimeException("Class Psr\Log\AbstractLogger not found");
        } else {
            if !this->_logger && log {
                this->setLogger(new \Elastica\Log(this->getConfig("log")));
            }
        }
        if this->_logger {
            if context instanceof \Elastica\Request {
                let data = context->toArray();
            } else {
                let data["message"] = context;
            }
            this->_logger->debug("logging Request", data);
        }
    }

    /**
     * @return \Elastica\Request
     */
    public function getLastRequest() -> <\Elastica\Request>
    {
        return this->_lastRequest;
    }

    /**
     * @return \Elastica\Response
     */
    public function getLastResponse() -> <\Elastica\Response>
    {
        return this->_lastResponse;
    }

    /**
     * set Logger
     *
     * @param LoggerInterface logger
     * @return this
     */
    public function setLogger(<\Psr\Log\LoggerInterface> logger)
    {
        let this->_logger = logger;

        return this;
    }
}
