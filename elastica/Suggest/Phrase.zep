namespace Elastica\Suggest;

/**
 * Class Phrase
 * @package Elastica\Suggest
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-suggesters-phrase.html
 */
class Phrase extends AbstractSuggest
{
    /**
     * @param string analyzer
     * @return \Elastica\Suggest\Phrase
     */
    public function setAnalyzer(string analyzer) -> <\Elastica\Suggest\Phrase>
    {
        return this->setParam("analyzer", analyzer);
    }

    /**
     * Set the max size of the n-grams (shingles) in the field
     * @param int size
     * @return \Elastica\Suggest\Phrase
     */
    public function setGramSize(int size) -> <\Elastica\Suggest\Phrase>
    {
        return this->setParam("gram_size", size);
    }

    /**
     * Set the likelihood of a term being misspelled even if the term exists in the dictionary
     * @param float likelihood Defaults to 0.95, meaning 5% of the words are misspelled.
     * @return \Elastica\Suggest\Phrase
     */
    public function setRealWorldErrorLikelihood(var likelihood)-> <\Elastica\Suggest\Phrase>
    {
        return this->setParam("real_world_error_likelihood", likelihood);
    }

    /**
     * Set the factor applied to the input phrases score to be used as a threshold for other suggestion candidates.
     * Only candidates which score higher than this threshold will be included in the result.
     * @param float confidence Defaults to 1.0.
     * @return \Elastica\Suggest\Phrase
     */
    public function setConfidence(var confidence) -> <\Elastica\Suggest\Phrase>
    {
        return this->setParam("confidence", confidence);
    }

    /**
     * Set the maximum percentage of the terms considered to be misspellings in order to form a correction
     * @param float max
     * @return \Elastica\Suggest\Phrase
     */
    public function setMaxErrors(var max) -> <\Elastica\Suggest\Phrase>
    {
        return this->setParam("max_errors", max);
    }

    /**
     * @param string separator
     * @return \Elastica\Param
     */
    public function setSeparator(string separator) -> <\Elastica\Param>
    {
        return this->setParam("separator", separator);
    }

    /**
     * Set suggestion highlighting
     * @param string preTag
     * @param string postTag
     * @return \Elastica\Suggest\Phrase
     */
    public function setHighlight(string preTag, string postTag) -> <\Elastica\Suggest\Phrase>
    {
        var data = [];
        let data["pre_tag"] = preTag;
        let data["post_tag"] = postTag;

        return this->setParam("highlight", data);
    }

    /**
     * @param float discount
     * @return \Elastica\Suggest\Phrase
     */
    public function setStupidBackoffSmoothing(var discount = 0.4) -> <\Elastica\Suggest\Phrase>
    {
        return this->setSmoothingModel("stupid_backoff", [
            "discount": discount
        ]);
    }

    /**
     * @param float alpha
     * @return \Elastica\Suggest\Phrase
     */
    public function setLaplaceSmoothing(var alpha = 0.5) -> <\Elastica\Suggest\Phrase>
    {
        return this->setSmoothingModel("laplace", [
            "alpha": alpha
        ]);
    }

    /**
     * @param float trigramLambda
     * @param float bigramLambda
     * @param float unigramLambda
     * @return \Elastica\Suggest\Phrase
     */
    public function setLinearInterpolationSmoothing(
        var trigramLambda,
        var bigramLambda,
        var unigramLambda
    ) -> <\Elastica\Suggest\Phrase>
    {
        return this->setSmoothingModel("linear_interpolation", [
            "trigram_lambda": trigramLambda,
            "bigram_lambda": bigramLambda,
            "unigram_lambda": unigramLambda
        ]);
    }

    /**
     * @param string model the name of the smoothing model
     * @param array params
     * @return \Elastica\Suggest\Phrase
     */
    public function setSmoothingModel(string model, array params) -> <\Elastica\Suggest\Phrase>
    {
        return this->setParam("smoothing", [
            model: params
        ]);
    }

    /**
     * @param AbstractCandidateGenerator generator
     * @return \Elastica\Suggest\Phrase
     */
    public function addCandidateGenerator(<\Elastica\Suggest\CandidateGenerator\AbstractCandidateGenerator> generator) -> <\Elastica\Suggest\Phrase>
    {
        var keys, values;
        let generator = generator->toArray();
        let keys = array_keys(generator);
        let values = array_values(generator);
        return this->addParam(keys[0], values[0]);
    }
}