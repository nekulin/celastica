namespace Elastica\Cluster;

/**
 * Elastic cluster health.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-health.html
 */
class Health
{
    /**
     * Elastica client.
     *
     * @var \Elastica\Client Client object
     */
    protected _client = null;

    /**
     * The cluster health data.
     *
     * @var array
     */
    protected _data = null;

    /**
     * @param \Elastica\Client client The Elastica client.
     */
    public function __construct(<\Elastica\Client> client) -> void
    {
        let this->_client = client;
        this->refresh();
    }

    /**
     * Retrieves the health data from the cluster.
     *
     * @return array
     */
    protected function _retrieveHealthData() -> array
    {
        var path, response;
        let path = "_cluster/health?level=shards";
        let response = this->_client->request(path, \Elastica\Request::GET);

        return response->getData();
    }

    /**
     * Gets the health data.
     *
     * @return array
     */
    public function getData() -> array
    {
        return this->_data;
    }

    /**
     * Refreshes the health data for the cluster.
     *
     * @return \Elastica\Cluster\Health
     */
    public function refresh()
    {
        let this->_data = this->_retrieveHealthData();

        return this;
    }

    /**
     * Gets the name of the cluster.
     *
     * @return string
     */
    public function getClusterName() -> string
    {
        return this->_data["cluster_name"];
    }

    /**
     * Gets the status of the cluster.
     *
     * @return string green, yellow or red.
     */
    public function getStatus() -> string
    {
        return this->_data["status"];
    }

    /**
     * TODO determine the purpose of this.
     *
     * @return bool
     */
    public function getTimedOut() -> boolean
    {
        return this->_data["timed_out"];
    }

    /**
     * Gets the number of nodes in the cluster.
     *
     * @return int
     */
    public function getNumberOfNodes() -> int
    {
        return this->_data["number_of_nodes"];
    }

    /**
     * Gets the number of data nodes in the cluster.
     *
     * @return int
     */
    public function getNumberOfDataNodes() -> int
    {
        return this->_data["number_of_data_nodes"];
    }

    /**
     * Gets the number of active primary shards.
     *
     * @return int
     */
    public function getActivePrimaryShards() -> int
    {
        return this->_data["active_primary_shards"];
    }

    /**
     * Gets the number of active shards.
     *
     * @return int
     */
    public function getActiveShards() -> int
    {
        return this->_data["active_shards"];
    }

    /**
     * Gets the number of relocating shards.
     *
     * @return int
     */
    public function getRelocatingShards() -> int
    {
        return this->_data["relocating_shards"];
    }

    /**
     * Gets the number of initializing shards.
     *
     * @return int
     */
    public function getInitializingShards()
    {
        return this->_data["initializing_shards"];
    }

    /**
     * Gets the number of unassigned shards.
     *
     * @return int
     */
    public function getUnassignedShards()
    {
        return this->_data["unassigned_shards"];
    }

    /**
     * Gets the status of the indices.
     *
     * @return \Elastica\Cluster\Health\Index[]
     */
    public function getIndices() -> array
    {
        var indices, dataIndices, indexName, index;

        let indices = [];
        let dataIndices = this->_data["indices"];
        for indexName, index in dataIndices {
            let indices[] = new \Elastica\Index(indexName, index);
        }

        return indices;
    }
}