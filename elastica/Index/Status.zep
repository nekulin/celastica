namespace Elastica\Index;

/**
 * Elastica index status object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-indices-status.html
 */
class Status
{
    /**
     * Response
     *
     * @var \Elastica\Response Response object
     */
    protected _response = null;

    /**
     * Stats info
     *
     * @var array Stats info
     */
    protected _data = [];

    /**
     * Index
     *
     * @var \Elastica\Index Index object
     */
    protected _index = null;

    /**
     * Construct
     *
     * @param \Elastica\Index index Index object
     */
    public function __construct(<\Elastica\Index> index)
    {
        let this->_index = index;
        this->refresh();
    }

    /**
     * Returns all status info
     *
     * @return array Status info
     */
    public function getData() -> array
    {
        return this->_data;
    }

    /**
     * Returns the entry in the data array based on the params.
     * Various params possible.
     *
     * @return mixed Data array entry or null if not found
     */
    public function get()
    {
        var data, arg, args;
        let data = this->getData();
        let data = data["indices"][this->getIndex()->getName()];
        let args = func_get_args();

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
     * Returns all index aliases
     *
     * @return array Aliases
     */
    public function getAliases() -> array
    {
        var responseData;
        let responseData = this->getIndex()->request("_aliases", \Elastica\Request::GET)->getData();
        return array_keys(responseData[this->getIndex()->getName()]["aliases"]);
    }

    /**
     * Returns all index settings
     *
     * @return array Index settings
     */
    public function getSettings() -> array
    {
        var responseData;
        let responseData = this->getIndex()->request("_settings", \Elastica\Request::GET)->getData();
        return responseData[this->getIndex()->getName()]["settings"];
    }

    /**
     * Checks if the index has the given alias
     *
     * @param  string name Alias name
     * @return bool
     */
    public function hasAlias(string name) -> boolean
    {
        return in_array(name, this->getAliases());
    }

    /**
     * Returns the index object
     *
     * @return \Elastica\Index Index object
     */
    public function getIndex() -> <\Elastica\Index>
    {
        return this->_index;
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
     * Reloads all status data of this object
     */
    public function refresh()
    {
        var path;
        let path = "_status";
        let this->_response = this->getIndex()->request(path, \Elastica\Request::GET);
        let this->_data = this->getResponse()->getData();
    }
}