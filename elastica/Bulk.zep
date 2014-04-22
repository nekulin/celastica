namespace Elastica;

/**
 * Bulk
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Bulk
{
    const DELIMITER = "\n";

    const UDP_DEFAULT_HOST = "localhost";
    const UDP_DEFAULT_PORT = 9700;

    /**
     * @var \Elastica\Client
     */
    protected _client;

    /**
     * @var \Elastica\Bulk\Action[]
     */
    protected _actions = [];

    /**
     * @var string
     */
    protected _index = "";

    /**
     * @var string
     */
    protected _type = "";

    /**
     * @var array request parameters to the bulk api
     */
    protected _requestParams = [];

    /**
     * @param \Elastica\Client client
     */
    public function __construct(<\Elastica\Client> client)
    {
        let this->_client = client;
    }

    /**
     * @param string|\Elastica\Index index
     * @return \Elastica\Bulk
     */
    public function setIndex(index) -> <\Elastica\Bulk>
    {
        if index instanceof \Elastica\Index {
            let index = index->getName();
        }

        let this->_index = (string) index;

        return this;
    }

    /**
     * @return string
     */
    public function getIndex() -> string
    {
        return this->_index;
    }

    /**
     * @return bool
     */
    public function hasIndex() ->  boolean
    {
        return this->getIndex() !== "";
    }

    /**
     * @param string|\Elastica\Type type
     * @return \Elastica\Bulk
     */
    public function setType(var type) -> <\Elastica\Bulk>
    {
        if type instanceof \Elastica\Type {
            this->setIndex(type->getIndex()->getName());
            let type = type->getName();
        }

        let this->_type = (string) type;

        return this;
    }

    /**
     * @return string
     */
    public function getType() -> string
    {
        return this->_type;
    }

    /**
     * @return bool
     */
    public function hasType() -> boolean
    {
        return this->_type !== "";
    }

    /**
     * @return string
     */
    public function getPath() -> string
    {
        var path;
        let path = "";
        if this->hasIndex() {
            let path .= this->getIndex() . "/";
            if this->hasType() {
                let path .= this->getType() . "/";
            }
        }
        let path .= "_bulk";
        return path;
    }

    /**
     * @param \Elastica\Bulk\Action action
     * @return \Elastica\Bulk
     */
    public function addAction(<\Elastica\Bulk\Action> action) -> <\Elastica\Bulk>
    {
        let this->_actions[] = action;
        return this;
    }

    /**
     * @param \Elastica\Bulk\Action[] actions
     * @return \Elastica\Bulk
     */
    public function addActions(var actions) -> <\Elastica\Bulk>
    {
        var action;

        for action in actions {
            this->addAction(action);
        }
        
        return this;
    }

    /**
     * @return \Elastica\Bulk\Action[]
     */
    public function getActions()
    {
        return this->_actions;
    }

    /**
     * @param \Elastica\Document document
     * @param string opType
     * @return \Elastica\Bulk
     */
    public function addDocument(<\Elastica\Document> document, string opType = null) -> <\Elastica\Bulk>
    {
        var action;

        let action = \Elastica\Bulk\Action\AbstractDocument::create(document, opType);

        return this->addAction(action);
    }

    /**
     * @param \Elastica\Document[] documents
     * @param string opType
     * @return \Elastica\Bulk
     */
    public function addDocuments(var documents, string opType = null) -> <\Elastica\Bulk>
    {
        var document;

        for document in documents {
            this->addDocument(document, opType);
        }

        return this;
    }

    /**
     * @param \Elastica\Script data
     * @param string opType
     * @return \Elastica\Bulk
     */
    public function addScript(<\Elastica\Script> script, opType = null) -> <\Elastica\Bulk>
    {
        var action;

        let action = \Elastica\Bulk\Action\AbstractDocument::create(script, opType);

        return this->addAction(action);
    }

    /**
     * @param \Elastica\Document[] scripts
     * @param string opType
     * @return \Elastica\Bulk
     */
    public function addScripts(var scripts, string opType = null) -> <\Elastica\Bulk>
    {
        var document;

        for document in scripts {
            this->addScript(document, opType);
        }

        return this;
    }

    /**
     * @param \Elastica\Script|\Elastica\Document\array data
     * @param string opType
     * @return \Elastica\Bulk
     */
    public function addData(var data, string opType = null) -> <\Elastica\Bulk>
    {
        var actionData;

        if !is_array(data) {
            let data = [data];
        }

        for actionData in data {
            if actionData instanceof \Elastica\Script {
                this->addScript(actionData, opType);
            } else {
                if actionData instanceof \Elastica\Document {
                    this->addDocument(actionData, opType);
                } else {
                    throw new \InvalidArgumentException("Data should be a Document, a Script or an array containing Documents and/or Scripts");
                }
            }
        }

        return this;
    }

    /**
     * @param array data
     * @return \Elastica\Bulk
     * @throws \Elastica\Exception\InvalidException
     */
    public function addRawData(var data) -> <\Elastica\Bulk>
    {
        var row, opType, metadata, action;

        for row in data {
            if typeof row == "array" {
                let opType = key(row);
                let action = action;
                let metadata = reset(row);
                if \Elastica\Bulk\Action::isValidOpType(opType) {
                    // add previous action
                    if action {
                        this->addAction(action);
                    }
                    let action = new \Elastica\Bulk\Action(opType, metadata);
                } else {
                    if action {
                        action->setSource(row);
                        this->addAction(action);
                        let action = null;
                    } else {
                        throw new \Elastica\Exception\InvalidException("Invalid bulk data, source must follow action metadata");
                    }
                }
            } else {
                throw new \Elastica\Exception\InvalidException("Invalid bulk data, should be array of array, Document or Bulk/Action");
            }
        }

        // add last action if available
        if action {
            this->addAction(action);
        }

        return this;
    }

    /**
     * Set a url parameter on the request bulk request.
     * @var string name name of the parameter
     * @var string value value of the parameter
     */
    public function setRequestParam(string name, string value)
    {
        let this->_requestParams[name] = value;
    }

    /**
     * Set the amount of time that the request will wait the shards to come on line.
     * Requires Elasticsearch version >= 0.90.8.
     * @var string time timeout in Elasticsearch time format
     */
    public function setShardTimeout(string time)
    {
        this->setRequestParam("timeout", time );
    }

    /**
     * @return string
     */
    public function __toString() -> string
    {
        return this->toString();
    }

    /**
     * @return string
     */
    public function toString()
    {
        var data, actions, action;
        let data = "";
        let actions = this->getActions();
        for action in actions {
            let data .= action->toString();
        }

        return data;
    }

    /**
     * @return array
     */
    public function toArray()
    {
        var row, data, actions, action, actionArr;
        let data = [];
        let actions = this->getActions();
        for action in actions {
            let actionArr = action->toArray();
            for row in actionArr {
                let data[] = row;
            }
        }

        return data;
    }

    /**
     * @return \Elastica\Bulk\ResponseSet
     */
    public function send() -> <\Elastica\Bulk\ResponseSet>
    {
        var path, data, response;
        let path = this->getPath();
        let data = this->toString();

        let response = this->_client->request(path, \Elastica\Request::PUT, data, this->_requestParams);

        return this->_processResponse(response);
    }

    /**
     * @param \Elastica\Response response
     * @throws \Elastica\Exception\Bulk\ResponseException
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Bulk\ResponseSet
     */
    protected function _processResponse(<\Elastica\Response> response) -> <\Elastica\Bulk\ResponseSet>
    {
        var responseData, actions, bulkResponses, bulkResponseData, responseDataItems,
            action, data, dataInstance, opType, key, item, bulkResponseSet;

        let responseData = response->getData();
        let actions = this->getActions();
        let bulkResponses = [];

        if isset responseData["items"] && is_array(responseData["items"]) {
            let responseDataItems = responseData["items"];
            for key, item in responseDataItems {
                if !isset actions[key] {
                    throw new \Elastica\Exception\InvalidException("No response found for action #" . key);
                }

                let action = actions[key];
                let opType = key(item);
                let bulkResponseData = reset(item);

                if action instanceof \Elastica\Bulk\Action\AbstractDocument {
                    let data = action->getData();
                    let dataInstance = data instanceof \Elastica\Document;
                    if dataInstance && data->isAutoPopulate() || this->_client->getConfigValue(["document", "autoPopulate"], false)
                    {
                        if !data->hasId() && isset bulkResponseData["_id"] {
                            data->setId(bulkResponseData["_id"]);
                        }
                        if isset bulkResponseData["_version"] {
                            data->setVersion(bulkResponseData["_version"]);
                        }
                    }
                }

                let bulkResponses[] = new \Elastica\Bulk\Response(bulkResponseData, action, opType);
            }
        }

        let bulkResponseSet = new \Elastica\Bulk\ResponseSet(response, bulkResponses);

        if bulkResponseSet->hasError() {
            throw new \Elastica\Exception\Bulk\ResponseException(bulkResponseSet);
        }

        return bulkResponseSet;
    }

    /**
     * @param string host
     * @param int port
     * @throws \Elastica\Exception\Bulk\UdpException
     */
    public function sendUdp(var host = null, var port = null)
    {
        var message, socket, result;

        if null === host {
            let host = this->_client->getConfigValue(["udp", "host"], self::UDP_DEFAULT_HOST);
        }
        if null === port {
            let port = this->_client->getConfigValue(["udp", "port"], self::UDP_DEFAULT_PORT);
        }

        let message = this->toString();
        let socket = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);
        let result = socket_sendto(socket, message, strlen(message), 0, host, port);
        socket_close(socket);
        if false === result {
            throw new \Elastica\Exception\Bulk\UdpException("UDP request failed");
        }
    }
}
