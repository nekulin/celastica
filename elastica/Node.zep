namespace Elastica;

/**
 * Elastica cluster node object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-status.html
 */
class Node
{
    /**
     * Client
     *
     * @var \Elastica\Client
     */
    protected _client = null;

    /**
     * Node name
     *
     * @var string Node name
     */
    protected _name;

    /**
     * Node stats
     *
     * @var \Elastica\Node\Stats Node Stats
     */
    protected _stats = null;

    /**
     * Node info
     *
     * @var \Elastica\Node\Info Node info
     */
    protected _info = null;

    /**
     * Create a new node object
     *
     * @param string          name   Node name
     * @param \Elastica\Client client Node object
     */
    public function __construct(var name = "", <\Elastica\Client> client)
    {
        let this->_name = name;
        let this->_client = client;
        this->refresh();
    }

    /**
     * Get the name of the node
     *
     * @return string Node name
     */
    public function getName()
    {
        return this->_name;
    }

    /**
     * Returns the current client object
     *
     * @return \Elastica\Client Client
     */
    public function getClient()
    {
        return this->_client;
    }

    /**
     * Return stats object of the current node
     *
     * @return \Elastica\Node\Stats Node stats
     */
    public function getStats()
    {
        if (!this->_stats) {
            let this->_stats = new \Elastica\Node\Stats(this);
        }

        return this->_stats;
    }

    /**
     * Return info object of the current node
     *
     * @return \Elastica\Node\Info Node info object
     */
    public function getInfo()
    {
        if (!this->_info) {
            let this->_info = new \Elastica\Node\Info(this);
        }

        return this->_info;
    }

    /**
     * Refreshes all node information
     *
     * This should be called after updating a node to refresh all information
     */
    public function refresh()
    {
        let this->_stats = null;
        let this->_info = null;
    }

    /**
     * Shuts this node down
     *
     * @param  string            delay OPTIONAL Delay after which node is shut down (default = 1s)
     * @return \Elastica\Response
     * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-nodes-shutdown.html
     */
    public function shutdown(var delay = "1s")
    {
        var path;
        let path = "_cluster/nodes/" . this->getName() . "/_shutdown?delay=" . delay;

        return this->_client->request(path, \Elastica\Request::POST);
    }
}
