namespace Elastica;

/**
 * Cluster informations for elasticsearch
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/
 */
class Cluster
{
    /**
     * Client
     *
     * @var \Elastica\Client Client object
     */
    protected _client = null;

    /**
     * Cluster state response.
     *
     * @var \Elastica\Response
     */
    protected _response;

    /**
     * Cluster state data.
     *
     * @var array
     */
    protected _data;

    /**
     * Creates a cluster object
     *
     * @param \Elastica\Client client Connection client object
     */
    public function __construct(<\Elastica\Client> client)
    {
        let this->_client = client;
        this->refresh();
    }

    /**
     * Refreshes all cluster information (state)
     */
    public function refresh()
    {
        string path;
        let path = "_cluster/state";
        let this->_response = this->_client->request(path, \Elastica\Request::GET);
        let this->_data = this->getResponse()->getData();
    }

    /**
     * Returns the response object
     *
     * @return \Elastica\Response Response object
     */
    public function getResponse() -> <\Elastica\Response>
    {
        return this->_response;
    }

    /**
     * Return list of index names
     *
     * @return array List of index names
     */
    public function getIndexNames() -> array
    {
        var metaData, indices, key, value;

        let metaData = this->_data["metadata"]["indices"];

        let indices = [];
        for key, value in metaData {
            let indices[] = key;
        }

        return indices;
    }

    /**
     * Returns the full state of the cluster
     *
     * @return array State array
     * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-state.html
     */
    public function getState() -> array
    {
        return this->_data;
    }

    /**
     * Returns a list of existing node names
     *
     * @return array List of node names
     */
    public function getNodeNames() -> array
    {
        var data;
        let data = this->getState();

        return array_keys(data["routing_nodes"]["nodes"]);
    }

    /**
     * Returns all nodes of the cluster
     *
     * @return \Elastica\Node[]
     */
    public function getNodes() -> array
    {
        var name, nodes, nodeNames;
        let nodes = [];
        let nodeNames = this->getNodeNames();
        for name in nodeNames {
            let nodes[] = new \Elastica\Node(name, this->getClient());
        }

        return nodes;
    }

    /**
     * Returns the client object
     *
     * @return \Elastica\Client Client object
     */
    public function getClient() -> <\Elastica\Client>
    {
        return this->_client;
    }

    /**
     * Returns the cluster information (not implemented yet)
     *
     * @param  array                                      args Additional arguments
     * @throws \Elastica\Exception\NotImplementedException
     * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-nodes-info.html
     */
    public function getInfo(var args)
    {
        throw new \Elastica\Exception\NotImplementedException("not implemented yet");
    }

    /**
     * Return Cluster health
     *
     * @return \Elastica\Cluster\Health
     * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-health.html
     */
    public function getHealth() -> <\Elastica\Cluster\Health>
    {
        return new \Elastica\Cluster\Health(this->getClient());
    }

    /**
     * Return Cluster settings
     *
     * @return \Elastica\Cluster\Settings
     */
    public function getSettings() -> <\Elastica\Cluster\Settings>
    {
        return new \Elastica\Cluster\Settings(this->getClient());
    }

    /**
     * Shuts down the complete cluster
     *
     * @param  string            delay OPTIONAL Seconds to shutdown cluster after (default = 1s)
     * @return \Elastica\Response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-nodes-shutdown.html
     */
    public function shutdown(string delay = "1s") -> <\Elastica\Response>
    {
        string path;
        let path = "_shutdown?delay=" . delay;

        return this->_client->request(path, \Elastica\Request::POST);
    }
}
