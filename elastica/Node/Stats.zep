namespace Elastica\Node;

/**
 * Elastica cluster node object
 *
 * @category Xodoa
 * @package Elastica
 * @author Nicolas Ruflin <spam@ruflin.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-status.html
 */
class Stats
{
    /**
     * Response
     *
     * @var \Elastica\Response Response object
     */
    protected _response = null;

    /**
     * Stats data
     *
     * @var array stats data
     */
    protected _data = [];

    /**
     * Node
     *
     * @var \Elastica\Node Node object
     */
    protected _node = null;

    /**
     * Create new stats for node
     *
     * @param \Elastica\Node node Elastica node object
     */
    public function __construct(<Elastica\Node> node)
    {
        let this->_node = node;
        this->refresh();
    }

    /**
     * Returns all node stats as array based on the arguments
     *
     * Several arguments can be use
     * get(["index", "test", "example"])
     *
     * @return array Node stats for the given field or null if not found
     */
    public function get(var args = [])
    {
        var data, arg;
        let data = this->getData();

        for arg in args {
            if isset data[arg] {
                let data = data[arg];
            } else {
                return null;
            }
        }

        return data;
    }

    /**
     * Returns all stats data
     *
     * @return array Data array
     */
    public function getData()
    {
        return this->_data;
    }

    /**
     * Returns node object
     *
     * @return \Elastica\Node Node object
     */
    public function getNode()
    {
        return this->_node;
    }

    /**
     * Returns response object
     *
     * @return \Elastica\Response Response object
     */
    public function getResponse()
    {
        return this->_response;
    }

    /**
     * Reloads all nodes information. Has to be called if informations changed
     *
     * @return \Elastica\Response Response object
     */
    public function refresh()
    {
        var path, data;
        let path = "_nodes/" . this->getNode()->getName() . "/stats";
        let this->_response = this->getNode()->getClient()->request(path, \Elastica\Request::GET);
        let data = this->getResponse()->getData();
        let this->_data = reset(data["nodes"]);
    }
}