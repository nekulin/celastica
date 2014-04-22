namespace Elastica;

/**
 * Script objects, containing script internals
 *
 * @package Elastica
 * @author aris kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/modules/scripting.html
 */
class Script extends Param
{
    const LANG_MVEL   = "mvel";
    const LANG_JS     = "js";
    const LANG_GROOVY = "groovy";
    const LANG_PYTHON = "python";
    const LANG_NATIVE = "native";

    /**
     * @var string
     */
    private _script;

    /**
     * @var string
     */
    private _lang;

    /**
     * @var \Elastica\Document
     */
    protected _upsert;

    /**
     * @param string      script
     * @param array|null  params
     * @param string|null lang
     */
    public function __construct(string script, var params = null, var lang = null, var id = null)
    {
        this->setScript(script);
        if params {
            this->setParams(params);
        }
        if lang {
            this->setLang(lang);
        }

        if id {
            this->setId(id);
        }
    }

    /**
     * @param string lang
     */
    public function setLang(lang)
    {
        let this->_lang = lang;
    }

    /**
     * @return string
     */
    public function getLang()
    {
        return this->_lang;
    }

    /**
     * @param string script
     */
    public function setScript(script)
    {
        let this->_script = script;
    }

    /**
     * @return string
     */
    public function getScript()
    {
        return this->_script;
    }

    /**
     * @param  string|array|\Elastica\Script        data
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Script
     */
    public static function create(var data) -> <\Elastica\Script>
    {
        var script, letscript;

        if data instanceof self {
            let letscript = data;
        } else {
            if typeof data == "array" {
                let script = self::_createFromArray(data);
            } else {
                if typeof data == "string" {
                    let script = new self(data);
                } else {
                    throw new \Elastica\Exception\InvalidException("Failed to create script. Invalid data passed.");
                }
            }
        }
        return script;
    }

    /**
     * @param \Elastica\Document|array data
     * @return \Elastica\Document
     */
    public function setUpsert(var data) -> <\Elastica\Document>
    {
        var document;
        let document = \Elastica\Document::create(data);
        let this->_upsert = document;

        return this;
    }

    /**
     * @return \Elastica\Document
     */
    public function getUpsert() -> <\Elastica\Document>
    {
        return this->_upsert;
    }

    /**
     * @return bool
     */
    public function hasUpsert() -> boolean
    {
        return null !== this->_upsert;
    }

    /**
     * Sets the id of the document the script updates.
     *
     * @param  string            id
     * @return \Elastica\Script
     */
    public function setId(string id) -> <\Elastica\Script>
    {
        return this->setParam("_id", id);
    }

    /**
     * Returns id of the document the script updates.
     *
     * @return string|int Document id
     */
    public function getId() -> var
    {
        return this->hasParam("_id") ? this->getParam("_id") : null;
    }

    /**
     * @return bool
     */
    public function hasId() -> boolean
    {
        return (bool) this->getId();
    }

    /**
     * @param array fields if empty array all options will be returned, field names can be either with underscored either without, i.e. _percolate, routing
     * @param bool withUnderscore should option keys contain underscore prefix
     * @return array
     */
    public function getOptions(var fields = [], boolean withUnderscore = false) -> array
    {
        var data, field, key, value;

        if !empty fields {
            let data = [];

            for field in fields {
                let key = "_" . ltrim(field, "_");
                if this->hasParam(key) && this->getParam(key) !== "" {
                    let data[key] = this->getParam(key);
                }
            }
        } else {
            let data = this->getParams();
        }

        if !withUnderscore {
            for key, value in data {
                let data[ltrim(key, "_")] = value;
                unset(data[key]);
            }
        }
        return data;
    }

    /**
     * @param  array                               data
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Script
     */
    protected static function _createFromArray(var data) -> <\Elastica\Script>
    {
        var script;

        if !isset data["script"] {
            throw new \Elastica\Exception\InvalidException(data["script"] . " is required");
        }

        let script = new self(data["script"]);

        if isset data["lang"] {
            script->setLang(data["lang"]);
        }
        if isset data["params"] {
            if typeof data["params"] != "array" {
                throw new \Elastica\Exception\InvalidException(data["params"] . " should be array");
            }
            script->setParams(data["params"]);
        }

        return script;
    }

    /**
     * @return array
     */
    public function toArray()
    {
        var arr;
        let arr = [];
        let arr["script"] = this->_script;

        if !empty this->_params {
            let arr["params"] = this->_params;
        }
        if this->_lang {
            let arr["lang"] = this->_lang;
        }

        return arr;
    }
}
