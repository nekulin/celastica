namespace Elastica\Suggest;

/**
 * Class AbstractSuggestion
 * @package Elastica\Suggest
 */
abstract class AbstractSuggest extends \Elastica\Param
{
    /**
     * @var string the name of this suggestion
     */
    protected _name;

    /**
     * @var string the text for this suggestion
     */
    protected _text;

    /**
     * @param string name
     * @param string field
     */
    public function __construct(string name, string field) -> void
    {
        let this->_name = name;
        this->setField(field);
    }

    /**
     * Suggest text must be set either globally or per suggestion
     * @param string text
     * @return \Elastica\Suggest\AbstractSuggest
     */
    public function setText(string text) -> <\Elastica\Suggest\AbstractSuggest>
    {
        let this->_text = text;
        return this;
    }

    /**
     * @param string field
     * @return \Elastica\Suggest\AbstractSuggest
     */
    public function setField(string field) -> <\Elastica\Suggest\AbstractSuggest>
    {
        return this->setParam("field", field);
    }

    /**
     * @param int size
     * @return \Elastica\Suggest\AbstractSuggest
     */
    public function setSize(int size) -> <\Elastica\Suggest\AbstractSuggest>
    {
        return this->setParam("size", size);
    }

    /**
     * @param int size maximum number of suggestions to be retrieved from each shard
     * @return \Elastica\Suggest\AbstractSuggest
     */
    public function setShardSize(int size) -> <\Elastica\Suggest\AbstractSuggest>
    {
        return this->setParam("shard_size", size);
    }

    /**
     * Retrieve the name of this suggestion
     * @return string
     */
    public function getName() -> string
    {
        return this->_name;
    }

    /**
     * @return array
     */
    public function toArray() -> array
    {
        var arr;
        let arr = parent::toArray();
        if isset this->_text {
            let arr["text"] = this->_text;
        }
        return arr;
    }
}