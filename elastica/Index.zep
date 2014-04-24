namespace Elastica;

/**
 * Elastica index object
 *
 * Handles reads, deletes and configurations of an index
 *
 * @package  Elastica
 * @author   Aris Kemper <aris.github@gmail.com>
 */
class Index implements SearchableInterface
{
    /**
     * Index name
     *
     * @var string Index name
     */
    protected _name = "";

    /**
     * Client object
     *
     * @var \Elastica\Client Client object
     */
    protected _client = null;

    /**
     * Creates a new index object
     *
     * All the communication to and from an index goes of this object
     *
     * @param  \Elastica\Client client Client object
     * @param  string name Index name
     * @throws \Elastica\Exception\InvalidException
     */
    public function __construct(<\Elastica\Client> client, string name)
    {
        let this->_client = client;

        if !is_string(name) {
            throw new \Elastica\Exception\InvalidException("Index name should be of type string");
        }
        let this->_name = name;
    }

    /**
     * Returns a type object for the current index with the given name
     *
     * @param  string type Type name
     * @return \Elastica\Type Type object
     */
    public function getType(string type) -> <\Elastica\Type>
    {
        return new \Elastica\Type(this, type);
    }

    /**
     * Returns the current status of the index
     *
     * @return \Elastica\Index\Status Index status
     */
    public function getStatus() -> <\Elastica\Index\Status>
    {
        return new \Elastica\Index\Status(this);
    }

    /**
     * Return Index Stats
     *
     * @return \Elastica\Index\Stats
     */
    public function getStats() -> <\Elastica\Index\Stats>
    {
        return new \Elastica\Index\Stats(this);
    }

    /**
     * Gets all the type mappings for an index.
     *
     * @return array
     */
    public function getMapping() -> array
    {
        var path, response, data, mapping;

        let path = "_mapping";

        let response = this->request(path, \Elastica\Request::GET);
        let data = response->getData();

        // Get first entry as if index is an Alias, the name of the mapping is the real name and not alias name
        let mapping = array_shift(data);

        if isset mapping["mappings"] {
            return mapping["mappings"];
        }

        return [];
    }

    /**
     * Returns the index settings object
     *
     * @return \Elastica\Index\Settings Settings object
     */
    public function getSettings() -> <\Elastica\Index\Settings>
    {
        return new \Elastica\Index\Settings(this);
    }

    /**
    * Sets docs index
    *
    * @param array docs
    * @return array docs
    */
    protected function _setDocsIndex(var docs) -> array
    {
        var doc;

        for doc in docs {
            doc->setIndex(this->getName());
        }
        return docs;
    }

    /**
     * Uses _bulk to send documents to the server
     *
     * @param  array|\Elastica\Document[] docs Array of Elastica\Document
     * @return \Elastica\Bulk\ResponseSet
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function updateDocuments(var docs) -> <\Elastica\Bulk\ResponseSet>
    {
        return this->getClient()->updateDocuments(this->_setDocsIndex(docs));
    }

    /**
     * Uses _bulk to send documents to the server
     *
     * @param  array|\Elastica\Document[] docs Array of Elastica\Document
     * @return \Elastica\Bulk\ResponseSet
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function addDocuments(var docs) -> <\Elastica\Bulk\ResponseSet>
    {
        return this->getClient()->addDocuments(this->_setDocsIndex(docs));
    }

    /**
     * Deletes the index
     *
     * @return \Elastica\Response Response object
     */
    public function delete() -> <\Elastica\Response>
    {
        var response;
        let response = this->request("", \Elastica\Request::DELETE);

        return response;
    }

    /**
     * Uses _bulk to delete documents from the server
     *
     * @param  array|\Elastica\Document[] docs Array of Elastica\Document
     * @return \Elastica\Bulk\ResponseSet
     * @link http://www.elasticsearch.org/guide/reference/api/bulk.html
     */
    public function deleteDocuments(var docs) -> <\Elastica\Bulk\ResponseSet>
    {
        return this->getClient()->deleteDocuments(this->_setDocsIndex(docs));
    }

    /**
     * Optimizes search index
     *
     * Detailed arguments can be found here in the link
     *
     * @param  array args OPTIONAL Additional arguments
     * @return array Server response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-optimize.html
     */
    public function optimize(var args = [])
    {
        this->request("_optimize", \Elastica\Request::POST, [], args);
    }

    /**
     * Refreshes the index
     *
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-refresh.html
     */
    public function refresh() -> <\Elastica\Response>
    {
        return this->request("_refresh", \Elastica\Request::POST, []);
    }

    /**
     * Creates a new index with the given arguments
     *
     * @param array args OPTIONAL Arguments to use
     * @param bool|array options OPTIONAL
     *                            bool=> Deletes index first if already exists (default = false).
     *                            array => Associative array of options (option=>value)
     * @throws \Elastica\Exception\InvalidException
     * @throws \Elastica\Exception\ResponseException
     * @return array                                Server response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-create-index.html
     */
    public function create(var args = [], var options = null)
    {
        string path;
        var query, key, value;

        let path = "";
        let query = [];

        if typeof options == "boolean" {
            if options {
                try {
                    this->delete();
                } catch Exception {
                    throw new \Elastica\Exception\ResponseException("Table can't be deleted, because it doesn't exist");
                }
            }
        } else {
            if typeof options == "array" {
                for key, value in options {
                    switch (key) {
                        case "recreate" :
                             //todo implement try catch when zephir support it
                             this->delete();
                            break;
                        case "routing" :
                            let query["routing"] = value;
                            break;
                        default:
                            throw new \Elastica\Exception\InvalidException("Invalid option " . key);
                            break;
                    }
                }
            }
        }

        return this->request(path, \Elastica\Request::PUT, args, query);
    }

    /**
     * Checks if the given index is already created
     *
     * @return bool True if index exists
     */
    public function exists() -> boolean
    {
        var response, info;

        let response = this->getClient()->request(this->getName(), \Elastica\Request::HEAD);
        let info = response->getTransferInfo();

        return (bool)(info["http_code"] == 200);
    }

    /**
     * @param  string query
     * @param  int|array options
     * @return \Elastica\Search
     */
    public function createSearch(string query = "", var options = null) -> <\Elastica\Search>
    {
        var search;
        let search = new \Elastica\Search(this->getClient());
        search->addIndex(this);
        search->setOptionsAndQuery(options, query);

        return search;
    }

    /**
     * Searches in this index
     *
     * @param  string|array|\Elastica\Query query Array with all query data inside or a Elastica\Query object
     * @param  int|array options OPTIONAL Limit or associative array of options (option=>value)
     * @return \Elastica\ResultSet          ResultSet with all results inside
     * @see \Elastica\SearchableInterface::search
     */
    public function search(string query = "", var options = null) -> <\Elastica\ResultSet>
    {
        var search;

        let search = this->createSearch(query, options);

        return search->search();
    }

    /**
     * Counts results of query
     *
     * @param  string|array|\Elastica\Query query Array with all query data inside or a Elastica\Query object
     * @return int                         number of documents matching the query
     * @see \Elastica\SearchableInterface::count
     */
    public function count(string query = "") -> int
    {
        var search;
        let search = this->createSearch(query);

        return search->count();
    }

    /**
     * Opens an index
     *
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-open-close.html
     */
    public function open()
    {
        this->request("_open", \Elastica\Request::POST);
    }

    /**
     * Closes the index
     *
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-open-close.html
     */
    public function close() -> <\Elastica\Response>
    {
        return this->request("_close", \Elastica\Request::POST);
    }

    /**
     * Returns the index name
     *
     * @return string Index name
     */
    public function getName() -> string
    {
        return this->_name;
    }

    /**
     * Returns index client
     *
     * @return \Elastica\Client Index client object
     */
    public function getClient() -> <\Elastica\Client>
    {
        return this->_client;
    }

    /**
     * Adds an alias to the current index
     *
     * @param  string name Alias name
     * @param  bool replace OPTIONAL If set, an existing alias will be replaced
     * @return \Elastica\Response Response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-aliases.html
     */
    public function addAlias(string name, boolean replace = false) -> <\Elastica\Response>
    {
        var path, status, index, indices, data = [];
        let path = "_aliases";

        let data["actions"] = [];

        if replace {
            let status = new \Elastica\Status(this->getClient());
            let indices = status->getIndicesWithAlias(name);
            for index in indices {
                let data["actions"][index]["remove"]["index"] = index->getName();
                let data["actions"][index]["remove"]["alias"] = name;
            }
        }

        /* to do
        let data["actions"][] = [
            "add": [
                "index": this->getName(),
                "alias": name
            ]
        ];*/

        return this->getClient()->request(path, \Elastica\Request::POST, data);
    }

    /**
     * Removes an alias pointing to the current index
     *
     * @param  string name Alias name
     * @return \Elastica\Response Response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-aliases.html
     */
    public function removeAlias(string name) -> <\Elastica\Response>
    {
        var path, data = [];
        let path = "_aliases";

        let data["actions"]["remove"]["index"] = this->getName();
        let data["actions"]["remove"]["alias"] = name;

        return this->getClient()->request(path, \Elastica\Request::POST, data);
    }

    /**
     * Clears the cache of an index
     *
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-clearcache.html
     */
    public function clearCache() -> <\Elastica\Response>
    {
        var path;
        let path = "_cache/clear";
        // TODO: add additional cache clean arguments
        return this->request(path, \Elastica\Request::POST);
    }

    /**
     * Flushes the index to storage
     *
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-flush.html
     */
    public function flush(boolean refresh = false) -> <\Elastica\Response>
    {
        var path;
        let path = "_flush";
        return this->request(path, \Elastica\Request::POST, [], ["refresh": refresh]);
    }

    /**
     * Can be used to change settings during runtime. One example is to use
     * if for bulk updating {@link http://www.elasticsearch.org/blog/2011/03/23/update-settings.html}
     *
     * @param  array data Data array
     * @return \Elastica\Response Response object
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-update-settings.html
     */
    public function setSettings(var data) -> <\Elastica\Response>
    {
        return this->request("_settings", \Elastica\Request::PUT, data);
    }

    /**
     * Makes calls to the elasticsearch server based on this index
     *
     * @param  string path Path to call
     * @param  string method Rest method to use (GET, POST, DELETE, PUT)
     * @param  array data OPTIONAL Arguments as array
     * @param  array query OPTIONAL Query params
     * @return \Elastica\Response Response object
     */
    public function request(string path, string method, var data = [], var query = []) -> <\Elastica\Response>
    {
        let path = this->getName() . "/" . path;

        return this->getClient()->request(path, method, data, query);
    }

    /**
     * Analyzes a string
     *
     * Detailed arguments can be found here in the link
     *
     * @param  string text String to be analyzed
     * @param  array args OPTIONAL Additional arguments
     * @return array Server response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-analyze.html
     */
    public function analyze(string text, var args = []) -> array
    {
        var data;
        let data = this->request("_analyze", \Elastica\Request::POST, text, args)->getData();
        return data["tokens"];
    }
}