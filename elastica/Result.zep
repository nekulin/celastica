namespace Elastica;

/**
 * Elastica result item
 *
 * Stores all information from a result
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Result
{
    /**
     * Hit array
     *
     * @var array Hit array
     */
    protected _hit = [];

    /**
     * Constructs a single results object
     *
     * @param array hit Hit data
     */
    public function __construct(var hit) -> void
    {
        let this->_hit = hit;
    }

    /**
     * Returns a param from the result hit array
     *
     * This function can be used to retrieve all data for which a specific
     * function doesn"t exist.
     * If the param does not exist, an empty array is returned
     *
     * @param  string name Param name
     * @return array  Result data
     */
    public function getParam(string name) -> array
    {
        if isset this->_hit[name] {
            return this->_hit[name];
        }

        return [];
    }

    /**
     * Test if a param from the result hit is set
     *
     * @param  string  name Param name to test
     * @return boolean True if the param is set, false otherwise
     */
    public function hasParam(string name) -> boolean
    {
        return isset this->_hit[name];
    }

    /**
     * Returns the hit id
     *
     * @return string Hit id
     */
    public function getId() -> string
    {
        return this->getParam("_id");
    }

    /**
     * Returns the type of the result
     *
     * @return string Result type
     */
    public function getType() -> string
    {
        return this->getParam("_type");
    }

    /**
     * Returns list of fields
     *
     * @return array Fields list
     */
    public function getFields() -> var
    {
        return this->getParam("fields");
    }

    /**
     * Returns whether result has fields
     *
     * @return bool
     */
    public function hasFields() -> boolean
    {
        return this->hasParam("fields");
    }

    /**
     * Returns the index name of the result
     *
     * @return string Index name
     */
    public function getIndex() -> string
    {
        return this->getParam("_index");
    }

    /**
     * Returns the score of the result
     *
     * @return float Result score
     */
    public function getScore() -> var
    {
        return this->getParam("_score");
    }

    /**
     * Returns the raw hit array
     *
     * @return array Hit array
     */
    public function getHit() -> var
    {
        return this->_hit;
    }

    /**
     * Returns the version information from the hit
     *
     * @return string|int Document version
     */
    public function getVersion() -> var
    {
        return this->getParam("_version");
    }

    /**
     * Returns result data
     *
     * Checks for partial result data with getFields, falls back to getSource
     *
     * @return array Result data array
     */
    public function getData()
    {
        if isset this->_hit["fields"] && !isset this->_hit["_source"] {
            return this->getFields();
        }

        return this->getSource();
    }

    /**
     * Returns the result source
     *
     * @return array Source data array
     */
    public function getSource() -> var
    {
        return this->getParam("_source");
    }

    /**
     * Returns result data
     *
     * @return array Result data array
     */
    public function getHighlights() -> var
    {
        return this->getParam("highlight");
    }

    /**
     * Returns explanation on how its score was computed.
     *
     * @return array explanations
     */
    public function getExplanation() -> var
    {
        return this->getParam("_explanation");
    }

    /**
     * Magic function to directly access keys inside the result
     *
     * Returns null if key does not exist
     *
     * @param  string key Key name
     * @return mixed  Key value
     */
    public function __get(string key)
    {
        var source;
        let source = this->getData();

        return array_key_exists(key, source) ? source[key] : null;
    }

    /**
     * Magic function to support isset() calls
     *
     * @param string key Key name
     * @return bool
     */
    public function __isset(string key)
    {
        var source;
        let source = this->getData();

        return array_key_exists(key, source) && source[key] !== null;
    }
}