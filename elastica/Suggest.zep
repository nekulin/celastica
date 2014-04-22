namespace Elastica;

/**
 * Class Suggest
 * @package Elastica\Suggest
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-suggesters.html
 */
class Suggest extends Param
{
    /**
    * @param AbstractSuggest suggestion
    */
    public function __construct(<\Elastica\Suggest\AbstractSuggest> suggestion = NULL)
    {
        if suggestion != null {
            this->addSuggestion(suggestion);
        }
    }

    /**
    * Set the global text for this suggester
    * @param string text
    * @return \Elastica\Suggest
    */
    public function setGlobalText(string text) -> <\Elastica\Suggest>
    {
        return this->setParam("text", text);
    }

    /**
    * Add a suggestion to this suggest clause
    * @param AbstractSuggest suggestion
    * @return \Elastica\Suggest
    */
    public function addSuggestion(<\Elastica\Suggest\AbstractSuggest> suggestion) -> <\Elastica\Suggest>
    {
        return this->setParam(suggestion->getName(), suggestion->toArray());
    }

    /**
    * @param Suggest|AbstractSuggest suggestion
    * @return \Elastica\Suggest
    * @throws Exception\NotImplementedException
    */
    public static function create(var suggestion) -> <\Elastica\Suggest>
    {
        /*todo

        switch(true){
            case suggestion instanceof \Elastica\Suggest:
                return suggestion;
            case suggestion instanceof \Elastica\Suggest\AbstractSuggest:
                return new self(suggestion);
        }*/
        throw new \Elastica\Exception\NotImplementedException();
    }
}