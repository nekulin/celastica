namespace Elastica\Suggest\CandidateGenerator;


/**
 * Class DirectGenerator
 *
 * @package Elastica\Suggest\Phrase
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-suggesters-phrase.html#_direct_generators
 */
class DirectGenerator extends AbstractCandidateGenerator
{
    const SUGGEST_MODE_MISSING = "missing";
    const SUGGEST_MODE_POPULAR = "popular";
    const SUGGEST_MODE_ALWAYS = "always";

    /**
     * @param string field
     */
    public function __construct(string field) -> void
    {
        this->setField(field);
    }

    /**
     * Set the field name from which to fetch candidate suggestions
     * @param string field
     * @return DirectGenerator
     */
    public function setField(string field) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("field", field);
    }

    /**
     * Set the maximum corrections to be returned per suggest text token
     * @param int size
     * @return DirectGenerator
     */
    public function setSize(int size) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("size", size);
    }

    /**
     * @param string mode see SUGGEST_MODE_* constants for options
     * @return DirectGenerator
     */
    public function setSuggestMode(string mode) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("suggest_mode", mode);
    }

    /**
     * @param int max can only be a value between 1 and 2. Defaults to 2.
     * @return DirectGenerator
     */
    public function setMaxEdits(int max) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("max_edits", max);
    }

    /**
     * @param int length defaults to 1
     * @return DirectGenerator
     */
    public function setPrefixLength(int length) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("prefix_len", length);
    }

    /**
     * @param int min defaults to 4
     * @return DirectGenerator
     */
    public function setMinWordLength(int min) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("min_word_len", min);
    }

    /**
     * @param int max
     * @return DirectGenerator
     */
    public function setMaxInspections(int max) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("max_inspections", max);
    }

    /**
     * @param float min
     * @return DirectGenerator
     */
    public function setMinDocFrequency(var min) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("min_doc_freq", min);
    }

    /**
     * @param float max
     * @return DirectGenerator
     */
    public function setMaxTermFrequency(var max) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("max_term_freq", max);
    }

    /**
     * Set an analyzer to be applied to the original token prior to candidate generation
     * @param string pre an analyzer
     * @return DirectGenerator
     */
    public function setPreFilter(string pre) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("pre_filter", pre);
    }

    /**
     * Set an analyzer to be applied to generated tokens before they are passed to the phrase scorer
     * @param string post
     * @return DirectGenerator
     */
    public function setPostFilter(string post) -> <\Elastica\Suggest\CandidateGenerator\DirectGenerator>
    {
        return this->setParam("post_filter", post);
    }
}