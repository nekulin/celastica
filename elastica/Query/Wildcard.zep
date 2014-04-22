namespace Elastica\Query;

/**
 * Wildcard query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/wildcard-query.html
 */
class Wildcard extends AbstractQuery
{
    /**
     * Construct wildcard query
     *
     * @param string key   OPTIONAL Wildcard key
     * @param string value OPTIONAL Wildcard value
     * @param float  boost OPTIONAL Boost value (default = 1)
     */
    public function __construct(string key = "", string value = null, var boost = 1.0) -> void
    {
        if !empty key {
            this->setValue(key, value, boost);
        }
    }

    /**
     * Sets the query expression for a key with its boost value
     *
     * @param  string                       key
     * @param  string                       value
     * @param  float                        boost
     * @return \Elastica\Query\Wildcard
     */
    public function setValue(string key, string value, var boost = 1.0) -> <\Elastica\Query\Wildcard>
    {
        var data = [];
        let data["value"] = value;
        let data["boost"] = boost;
        return this->setParam(key, data);
    }
}