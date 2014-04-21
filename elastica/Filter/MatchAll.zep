namespace Elastica\Filter;

/**
 * Match all filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/match-all-filter.html
 */
class MatchAll extends AbstractFilter
{
    /**
     * Creates match all filter
     */
    public function __construct()
    {
        let this->_params = new \stdClass();
    }
}