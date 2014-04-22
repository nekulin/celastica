namespace Elastica\Query;

/**
 * Match all query. Returns all results
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/match-all-query.html
 */
class MatchAll extends AbstractQuery
{
    /**
     * Creates match all query
     */
    public function __construct()
    {
        let this->_params = new \stdClass();
    }
}