namespace Elastica\Query;

/**
 * Nested query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/nested-query.html
 */
class Nested extends AbstractQuery
{
    /**
     * Adds field to mlt query
     *
     * @param  string                     path Nested object path
     * @return \Elastica\Query\Nested
     */
    public function setPath(string path) -> <\Elastica\Query\Nested>
    {
        return this->setParam("path", path);
    }

    /**
     * Sets nested query
     *
     * @param  \Elastica\Query\AbstractQuery query
     * @return \Elastica\Query\Nested
     */
    public function setQuery(<\Elastica\Query\AbstractQuery> query) -> <\Elastica\Query\Nested>
    {
        return this->setParam("query", query->toArray());
    }

    /**
     * Set score method
     *
     * @param  string                     scoreMode Options: avg, total, max and none.
     * @return \Elastica\Query\Nested
     */
    public function setScoreMode(string scoreMode) -> <\Elastica\Query\Nested>
    {
        return this->setParam("score_mode", scoreMode);
    }
}