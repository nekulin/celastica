namespace Elastica\Filter;

/**
 * Abstract filter object. Should be extended by all filter types
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/
 */
abstract class AbstractFilter extends \Elastica\Param
{
    /**
     * Sets the filter cache
     *
     * @param  boolean                        cached Cached
     * @return \Elastica\Filter\AbstractFilter
     */
    public function setCached(boolean cached = true) -> <\Elastica\Filter\AbstractFilter>
    {
        return this->setParam("_cache", cached);
    }

    /**
     * Sets the filter cache key
     *
     * @param  string                              cacheKey Cache key
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Filter\AbstractFilter
     */
    public function setCacheKey(string cacheKey) -> <\Elastica\Filter\AbstractFilter>
    {
        if empty cacheKey {
            throw new \Elastica\Exception\InvalidException("Invalid parameter. Has to be a non empty string");
        }

        return this->setParam("_cache_key", cacheKey);
    }

    /**
     * Sets the filter name
     *
     * @param  string                         name Name
     * @return \Elastica\Filter\AbstractFilter
     */
    public function setName(string name) -> <\Elastica\Filter\AbstractFilter>
    {
        return this->setParam("_name", name);
    }
}