namespace Elastica\Type;

/**
 * Elastica Mapping object
 *
 * @package Elastica
 * @author Aris Kemper <aris.kempeer@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/mapping/
 */
class Mapping
{
    /**
     * Mapping
     *
     * @var array Mapping
     */
    protected _mapping = [];

    /**
     * Type
     *
     * @var \Elastica\Type Type object
     */
    protected _type = null;

    /**
     * Construct Mapping
     *
     * @param \Elastica\Type type       OPTIONAL Type object
     * @param array         properties OPTIONAL Properties
     */
    public function __construct(<\Elastica\Type> type = null, var properties = [])
    {
        if type {
            this->setType(type);
        }

        if !empty properties {
            this->setProperties(properties);
        }
    }

    /**
     * Sets the mapping type
     * Enter description here ...
     * @param  \Elastica\Type             type Type object
     * @return \Elastica\Type\Mapping Current object
     */
    public function setType(<\Elastica\Type> type) -> <\Elastica\Type\Mapping>
    {
        let this->_type = type;

        return this;
    }

    /**
     * Sets the mapping properties
     *
     * @param  array                     properties Properties
     * @return \Elastica\Type\Mapping Mapping object
     */
    public function setProperties(array properties) -> <\Elastica\Type\Mapping>
    {
        return this->setParam("properties", properties);
    }

    /**
     * Gets the mapping properties
     *
     * @return  array                     properties Properties
     */
    public function getProperties() -> array
    {
        return this->getParam("properties");
    }

    /**
     * Sets the mapping _meta
     * @param array meta metadata
     * @return \Elastica\Type\Mapping Mapping object
     * @link http://www.elasticsearch.org/guide/reference/mapping/meta.html
     */
    public function setMeta(array meta) -> <\Elastica\Type\Mapping>
    {
        return this->setParam("_meta", meta);
    }

    /**
     * Returns mapping type
     *
     * @return \Elastica\Type Type
     */
    public function getType() -> <\Elastica\Type>
    {
        return this->_type;
    }

    /**
     * Sets source values
     *
     * To disable source, argument is
     * array("enabled" => false)
     *
     * @param  array                     source Source array
     * @return \Elastica\Type\Mapping Current object
     * @link http://www.elasticsearch.org/guide/reference/mapping/source-field.html
     */
    public function setSource(array source) -> <\Elastica\Type\Mapping>
    {
        return this->setParam("_source", source);
    }

    /**
     * Disables the source in the index
     *
     * Param can be set to true to enable again
     *
     * @param  bool                      enabled OPTIONAL (default = false)
     * @return \Elastica\Type\Mapping Current object
     */
    public function disableSource(boolean enabled = false) -> <\Elastica\Type\Mapping>
    {
        return this->setSource(["enabled": enabled]);
    }

    /**
     * Sets raw parameters
     *
     * Possible options:
     * _uid
     * _id
     * _type
     * _source
     * _all
     * _analyzer
     * _boost
     * _parent
     * _routing
     * _index
     * _size
     * properties
     *
     * @param  string                    key   Key name
     * @param  mixed                     value Key value
     * @return \Elastica\Type\Mapping Current object
     */
    public function setParam(string key, var value) -> <\Elastica\Type\Mapping>
    {
        let this->_mapping[key] = value;

        return this;
    }

    /**
     * Get raw parameters
     *
     * @see setParam
     * @param  string                    key   Key name
     * @return mixed                     value Key value
     */
    public function getParam(string key) -> var
    {
        return isset this->_mapping[key] ? this->_mapping[key] : null;
    }

    /**
     * Sets params for the "_all" field
     *
     * @param array                       params _all Params (enabled, store, term_vector, analyzer)
     * @return \Elastica\Type\Mapping
     */
    public function setAllField(array params) -> <\Elastica\Type\Mapping>
    {
        return this->setParam("_all", params);
    }

    /**
     * Enables the "_all" field
     *
     * @param  bool                      enabled OPTIONAL (default = true)
     * @return \Elastica\Type\Mapping
     */
    public function enableAllField(boolean enabled = true) -> <\Elastica\Type\Mapping>
    {
        return this->setAllField(["enabled": enabled]);
    }

    /**
     * Set TTL
     *
     * @param  array                     params TTL Params (enabled, default, ...)
     * @return \Elastica\Type\Mapping
     */
    public function setTtl(array params) -> <\Elastica\Type\Mapping>
    {
        return this->setParam("_ttl", params);

    }

    /**
     * Enables TTL for all documents in this type
     *
     * @param  bool                      enabled OPTIONAL (default = true)
     * @return \Elastica\Type\Mapping
     */
    public function enableTtl(boolean enabled = true) -> <\Elastica\Type\Mapping>
    {
        return this->setTTL(["enabled": enabled]);
    }

    /**
     * Set parent type
     *
     * @param string                     type Parent type
     * @return \Elastica\Type\Mapping
     */
    public function setParent(string type)
    {
        return this->setParam("_parent", ["type": type]);
    }

    /**
     * Converts the mapping to an array
     *
     * @throws \Elastica\Exception\InvalidException
     * @return array                               Mapping as array
     */
    public function toArray() -> array
    {
        var type, ret = [];
        let type = this->getType();

        if empty type {
            throw new \Elastica\Exception\InvalidException("Type has to be set");
        }
        let ret[type->getName()] = this->_mapping;
        return ret;
    }

    /**
     * Submits the mapping and sends it to the server
     *
     * @return \Elastica\Response Response object
     */
    public function send() -> <\Elastica\Response>
    {
        var path;
        let path = "_mapping";

        return this->getType()->request(path, \Elastica\Request::PUT, this->toArray());
    }

    /**
     * Creates a mapping object
     *
     * @param  array|\Elastica\Type\Mapping     mapping Mapping object or properties array
     * @return \Elastica\Type\Mapping           Mapping object
     * @throws \Elastica\Exception\InvalidException If invalid type
     */
    public static function create(var mapping) -> <\Elastica\Type\Mapping>
    {
        var mappingObject;
        if typeof mapping == "array" {
            let mappingObject = new \Elastica\Type\Mapping();
            mappingObject->setProperties(mapping);
        } else {
            let mappingObject = mapping;
        }

        if !(mappingObject instanceof \Elastica\Type\Mapping) {
            throw new \Elastica\Exception\InvalidException("Invalid object type");
        }

        return mappingObject;
    }
}