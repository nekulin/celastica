namespace Elastica\Node;

/**
 * Elastica cluster node object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-status.html
 */
class Info
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
     * Query parameters
     *
     * @var array
     */
    protected _params = [];

    /**
     * Create new info object for node
     *
     * @param \Elastica\Node node   Node object
     * @param array         params List of params to return. Can be: settings, os, process, jvm, thread_pool, network, transport, http
     */
    public function __construct(<\Elastica\Node> node, array params = [])
    {
        let this->_node = node;
        this->refresh(params);
    }

    /**
     * Returns the entry in the data array based on the params.
     * Several params possible.
     *
     * Example 1: get(["os", "mem", "total"]) returns total memory of the system the
     * node is running on
     * Example 2: get(["os", "mem"]) returns an array with all mem infos
     *
     * @return mixed Data array entry or null if not found
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
     * Return port of the node
     *
     * @return string Returns Node port
     */
    public function getPort() -> string
    {
        var data;
        // Returns string in format: inet[/192.168.1.115:9201]
        let data = this->get(["http_address"]);
        let data = substr(data, 6, strlen(data) - 7);
        let data = explode(":", data);

        return data[1];
    }

    /**
     * Return IP of the node
     *
     * @return string Returns Node ip address
     */
    public function getIp()
    {
        var data;
        // Returns string in format: inet[/192.168.1.115:9201]
        let data = this->get(["http_address"]);
        let data = substr(data, 6, strlen(data) - 7);
        let data = explode(":", data);

        return data[0];
    }

    /**
     * Return data regarding plugins installed on this node
     * @return array plugin data
     * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-nodes-info/
     */
    public function getPlugins() -> array
    {
        if !in_array("plugins", this->_params) {
            //Plugin data was not retrieved when refresh() was called last. Get it now.
            let this->_params[] = "plugins";
            this->refresh(this->_params);
        }
        return this->get(["plugins"]);
    }

    /**
     * Check if the given plugin is installed on this node
     * @param string name plugin name
     * @return bool true if the plugin is installed, false otherwise
     */
    public function hasPlugin(name)
    {
        var plugin, plugins;
        let plugins = this->getPlugins();

        for plugin in plugins {
            if plugin["name"] == name {
                return true;
            }
        }

        return false;
    }

    /**
     * Return all info data
     *
     * @return array Data array
     */
    public function getData() -> array
    {
        return this->_data;
    }

    /**
     * Return node object
     *
     * @return \Elastica\Node Node object
     */
    public function getNode() -> <\Elastica\Node>
    {
        return this->_node;
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
     * Reloads all nodes information. Has to be called if informations changed
     *
     * @param  array             params Params to return (default none). Possible options: settings, os, process, jvm, thread_pool, network, transport, http, plugin
     * @return \Elastica\Response Response object
     */
    public function refresh(var params = [])
    {
        var path, param, data;

        let this->_params = params;
        let path = "_nodes/" . this->getNode()->getName();

        if !empty params {
            let path .= "?";
            for param in params {
                let path .= param . "=true&";
            }
        }

        let this->_response = this->getNode()->getClient()->request(path, \Elastica\Request::GET);
        let data = this->getResponse()->getData();
        let this->_data = reset(data["nodes"]);
    }
}