namespace Elastica;

/**
 * Elastica general status
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-status.html
 */
class Status
{
/**
     * Contains all status infos
     *
     * @var \Elastica\Response Response object
     */
    protected _response = null;

    /**
     * Data
     *
     * @var array Data
     */
    protected _data = [];

    /**
     * Client object
     *
     * @var \Elastica\Client Client object
     */
    protected _client = null;

    /**
     * Constructs Status object
     *
     * @param \Elastica\Client client Client object
     */
    public function __construct(<\Elastica\Client>  client)
    {
        let this->_client = client;
        this->refresh();
    }

    /**
    * Returns status data
    *
    * @return array Status data
    */
    public function getData()
    {
        return this->_data;
    }

    /**
    * Returns status objects of all indices
    *
    * @return array|\Elastica\Index\Status[] List of Elastica\Client\Index objects
    */
    public function getIndexStatuses()
    {
        var indexName, index, name, statuses = [];
        let indexName = this->getIndexNames();
        for name in indexName {
            let index = new \Elastica\Index(this->_client, name);
            let statuses[] = new \Elastica\Index\Status(index);
        }

        return statuses;
    }

    /**
    * Returns a list of the existing index names
    *
    * @return array Index names list
    */
    public function getIndexNames() -> array
    {
        var names = [], name, data;

        for name, data in this->_data["indices"] {
            let names[] = name;
        }

        return names;
    }

    /**
    * Checks if the given index exists
    *
    * @param  string name Index name to check
    * @return bool   True if index exists
    */
    public function indexExists(string name) -> boolean
    {
        return in_array(name, this->getIndexNames());
    }

    /**
    * Checks if the given alias exists
    *
    * @param  string name Alias name
    * @return bool   True if alias exists
    */
    public function aliasExists(string name) -> boolean
    {
        var indexStatuses, status;

        let indexStatuses = this->getIndexStatuses();
        for status in indexStatuses {
            if status->hasAlias(name) {
                return true;
            }
        }

        return false;
    }

    /**
    * Returns an array with all indices that the given alias name points to
    *
    * @param  string                 name Alias name
    * @return array|\Elastica\Index[] List of Elastica\Index
    */
    public function getIndicesWithAlias(string alias)
    {
        var response = null, indices = [], transferInfo, e, name, unused;
        try {
            let response = this->_client->request("/_alias/" . alias);
        } catch \Elastica\Exception\ResponseException, e {
            let transferInfo = e->getResponse()->getTransferInfo();
            // 404 means the index alias doesn't exist which means no indexes have it.
            if (transferInfo["http_code"] === 404) {
                return [];
            }
            // If we don't have a 404 then this is still unexpected so rethrow the exception.
            throw e;
        }

        for name, unused in response->getData() {
            let indices[] = new \Elastica\Index(this->_client, name);
        }

        return indices;
    }

    /**
    * Returns response object
    *
    * @return \Elastica\Response Response object
    */
    public function getResponse() -> <\Elastica\Response>
    {
        return this->_response;
    }

    /**
    * Return shards info
    *
    * @return array Shards info
    */
    public function getShards()
    {
        return this->_data["shards"];
    }

    /**
    * Refresh status object
    */
    public function refresh()
    {
        var path = "_status";
        let this->_response = this->_client->request(path, \Elastica\Request::GET);
        let this->_data = this->getResponse()->getData();
    }

    /**
    * Refresh serverStatus object
    */
    public function getServerStatus()
    {
        var path = "", response;
        let response = this->_client->request(path, \Elastica\Request::GET);

        return  response->getData();
    }
}
