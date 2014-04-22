namespace Elastica;

/**
 * Class to handle params
 *
 * This function can be used to handle params for queries, filter, facets
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Param
{
    /**
     * Params
     *
     * @var array
     */
    protected _params = [];

    /**
     * Raw Params
     *
     * @var array
     */
    protected _rawParams = [];

    /**
     * Converts the params to an array. A default implementation exist to create
     * the an array out of the class name (last part of the class name)
     * and the params
     *
     * @return array Filter array
     */
    public function toArray() -> array
    {
        var data = [];
        let data[this->_getBaseName()] = this->getParams();

        if !empty this->_rawParams {
            let data = array_merge(data, this->_rawParams);
        }

        return data;
    }

    /**
     * Param"s name
     * Picks the last part of the class name and makes it snake_case
     * You can override this method if you want to change the name
     *
     * @return string name
     */
    protected function _getBaseName() -> string
    {
        return \Elastica\Util::getParamName(this);
    }

    /**
     * Sets params not inside params array
     *
     * @param  string         key
     * @param  mixed          value
     * @return \Elastica\Param
     */
    protected function _setRawParam(string key, var value) -> <\Elastica\Param>
    {
        let this->_rawParams[key] = value;

        return this;
    }

    /**
     * Sets (overwrites) the value at the given key
     *
     * @param  string         key   Key to set
     * @param  mixed          value Key Value
     * @return \Elastica\Param
     */
    public function setParam(string key, value) -> <\Elastica\Param>
    {
        let this->_params[key] = value;

        return this;
    }

    /**
     * Sets (overwrites) all params of this object
     *
     * @param  array          params Parameter list
     * @return \Elastica\Param
     */
    public function setParams(var params) -> <\Elastica\Param>
    {
        let this->_params = params;

        return this;
    }

    /**
     * Adds a param to the list.
     *
     * This function can be used to add an array of params
     *
     * @param  string         key   Param key
     * @param  mixed          value Value to set
     * @return \Elastica\Param
     */
    public function addParam(string key, value) -> <\Elastica\Param>
    {
        if key != null {
            if !isset this->_params[key] {
                let this->_params[key] = [];
            }
            //to do
            //let this->_params[key][] = value;
        } else {
            let this->_params = value;
        }

        return this;
    }

    /**
     * Returns a specific param
     *
     * @param  string                              key Key to return
     * @return mixed                               Key value
     * @throws \Elastica\Exception\InvalidException If requested key is not set
     */
    public function getParam(string key)
    {
        if !isset this->_params[key] {
            throw new \Elastica\Exception\InvalidException("Param " . key . " does not exist");
        }

        return this->_params[key];
    }

    /**
     * Test if a param is set
     *
     * @param  string  key Key to test
     * @return boolean True if the param is set, false otherwise
     */
    public function hasParam(key) -> boolean
    {
        return isset(this->_params[key]);
    }

    /**
     * Returns the params array
     *
     * @return array Params
     */
    public function getParams() -> array
    {
        return this->_params;
    }
}
