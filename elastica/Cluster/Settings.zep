namespace Elastica\Cluster;

/**
 * Cluster settings
 *
 * @package  Elastica
 * @author   Aris Kemper <aris.github@gmail.com>
 * @link     http://www.elasticsearch.org/guide/reference/api/admin-cluster-update-settings.html
 */
class Settings
{
    /**
     * Client
     *
     * @var \Elastica\Client Client object
     */
    protected _client = null;

    /**
     * Creates a cluster object
     *
     * @param \Elastica\Client client Connection client object
     */
    public function __construct(<\Elastica\Client> client)
    {
        let this->_client = client;
    }

    /**
     * Returns settings data
     *
     * @return array Settings data (persistent and transient)
     */
    public function get()
    {
        return this->request()->getData();
    }

    /**
     * Returns the current persistent settings of the cluster
     *
     * If param is set, only specified setting is return.
     *
     * @param  string setting OPTIONAL Setting name to return
     * @return array|string|null Settings data
     */
    public function getPersistent(string setting = "")
    {
        var data, settings;

        let data = this->get();
        let settings = data["persistent"];

        if !empty setting {
            if isset settings[setting] {
                return settings[setting];
            } else {
                return null;
            }
        }

        return settings;
    }

    /**
     * Returns the current transient settings of the cluster
     *
     * If param is set, only specified setting is return.
     *
     * @param  string setting OPTIONAL Setting name to return
     * @return array|string|null Settings data
     */
    public function getTransient(string setting = "")
    {
        var data, settings, keys, key;

        let data = this->get();
        let settings = data["transient"];

        if !empty setting {
            if (isset(settings[setting])) {
                return settings[setting];
            } else {
                if (strpos(setting, ".") !== false) {
                    // convert dot notation to nested arrays
                    let keys = explode(".", setting);
                    for key in keys {
                        if isset settings[key] {
                            let settings = settings[key];
                        } else {
                            return null;
                        }
                    }
                    return settings;
                }
                return null;
            }
        }

        return settings;
    }

    /**
     * Sets persistent setting
     *
     * @param  string key
     * @param  string value
     * @return \Elastica\Response
     */
    public function setPersistent(string key, string value) -> <\Elastica\Response>
    {
        var data = [];
        let data["persistent"][key] = value;

        return this->set(data);
    }

    /**
     * Sets transient settings
     *
     * @param  string key
     * @param  string value
     * @return \Elastica\Response
     */
    public function setTransient(string key, string value) -> <\Elastica\Response>
    {
        var data = [];
        let data["transient"][key] = value;

        return this->set(data);
    }

    /**
     * Sets the cluster to read only
     *
     * Second param can be used to set it persistent
     *
     * @param  bool readOnly
     * @param  bool persistent
     * @return \Elastica\Response response
     */
    public function setReadOnly(boolean readOnly = true, boolean persistent = false) -> <\Elastica\Response>
    {
        string key;
        var response;

        let key = "cluster.blocks.read_only";

        if persistent {
            let response = this->setPersistent(key, readOnly);
        } else {
            let response = this->setTransient(key, readOnly);
        }

        return response;
    }

    /**
     * Set settings for cluster
     *
     * @param  array settings Raw settings (including persistent or transient)
     * @return \Elastica\Response
     */
    public function set(array settings) -> <\Elastica\Response>
    {
        return this->request(settings, \Elastica\Request::PUT);
    }

    /**
     * Get the client
     *
     * @return \Elastica\Client
     */
    public function getClient() -> <\Elastica\Client>
    {
        return this->_client;
    }

    /**
     * Sends settings request
     *
     * @param  array data OPTIONAL Data array
     * @param  string method OPTIONAL Transfer method (default = \Elastica\Request::GET)
     * @return \Elastica\Response Response object
     */
    public function request(var data = [], var  method = null) -> <\Elastica\Response>
    {
        var path;
        let path = "_cluster/settings";
        if method == null {
            let method = \Elastica\Request::GET;
        }

        return this->getClient()->request(path, method, data);
    }
}