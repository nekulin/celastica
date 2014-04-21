namespace Elastica\Filter;

/**
 * Nested filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/nested-filter.html
 */
class Nested extends AbstractFilter
{
    /**
     * Adds field to mlt filter
     *
     * @param  string                       path Nested object path
     * @return \Elastica\Filter\Nested
     */
    public function setPath(string path) -> <\Elastica\Filter\Nested>
    {
        return this->setParam("path", path);
    }

    /**
     * Sets nested query
     *
     * @param  \Elastica\Query\AbstractQuery query
     * @return \Elastica\Filter\Nested
     */
    public function setQuery(<\Elastica\Query\AbstractQuery> query) -> <\Elastica\Filter\Nested>
    {
        return this->setParam("query", query->toArray());
    }

    /**
     * Sets nested filter
     *
     * @param  \Elastica\Filter\AbstractFilter filter
     * @return \Elastica\Filter\Nested
     */
    public function setFilter(<\Elastica\Query\AbstractQuery> filter) -> <\Elastica\Filter\Nested>
    {
        return this->setParam("filter", filter->toArray());
    }

    /**
     * Set score mode
     *
     * @param  string                       scoreMode Options: avg, total, max and none.
     * @return \Elastica\Filter\Nested
     */
    public function setScoreMode(string scoreMode) -> <\Elastica\Filter\Nested>
    {
        return this->setParam("score_mode", scoreMode);
    }
}