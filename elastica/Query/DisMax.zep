namespace Elastica\Query;

/**
 * DisMax query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-dis-max-query.html
 */
class DisMax extends AbstractQuery
{
    /**
     * Adds a query to the current object
     *
     * @param  \Elastica\Query\AbstractQuery|array  args Query
     * @return
     * @throws \Elastica\Exception\InvalidException If not valid query
     */
    public function addQuery(var args) -> <\Elastica\Query\DisMax>
    {
        if args instanceof \Elastica\Query\AbstractQuery {
            let args = args->toArray();
        }

        if typeof args != "array" {
            throw new \Elastica\Exception\InvalidException("Invalid parameter. Has to be array or instance of Elastica\Query\AbstractQuery");
        }

        return this->addParam("queries", args);
    }

    /**
     * Set boost
     *
     * @param  float                  boost
     * @return \Elastica\Query\DisMax
     */
    public function setBoost(var boost) -> <\Elastica\Query\DisMax>
    {
        return this->setParam("boost", boost);
    }

    /**
     * Sets tie breaker to multiplier value to balance the scores between lower and higher scoring fields.
     *
     * If not set, defaults to 0.0
     *
     * @param  float                  tieBreaker
     * @return \Elastica\Query\DisMax
     */
    public function setTieBreaker(var tieBreaker = 0.0) -> <\Elastica\Query\DisMax>
    {
        return this->setParam("tie_breaker", tieBreaker);
    }
}