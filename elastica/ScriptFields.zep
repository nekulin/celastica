namespace Elastica;

/**
 * Container for scripts as fields
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/script-fields.html
 */
class ScriptFields extends Param
{
    /**
     * @param \Elastica\Script[]|array scripts OPTIONAL
     */
    public function __construct(var scripts = [])
    {
        if scripts {
            this->setScripts(scripts);
        }
    }

    /**
     * @param  string                              name   Name of the Script field
     * @param  \Elastica\Script                     script
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\ScriptFields
     */
    public function addScript(string name, <\Elastica\Script>  script) -> <\Elastica\ScriptFields>
    {
        if typeof name != "string" || !strlen(name) {
            throw new \Elastica\Exception\InvalidException("The name of a Script is required and must be a string");
        }
        this->setParam(name, script->toArray());

        return this;
    }

    /**
     * @param  \Elastica\Script[]|array scripts Associative array of string => Elastica\Script
     * @return \Elastica\ScriptFields
     */
    public function setScripts(var scripts) -> <\Elastica\ScriptFields>
    {
        var name, script;

        let this->_params = [];
        for name, script in scripts {
            this->addScript(name, script);
        }

        return this;
    }

    /**
     * @return array
     */
    public function toArray()
    {
        return this->_params;
    }
}
