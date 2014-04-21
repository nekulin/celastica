namespace Elastica\Filter;

/**
 * Or Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/or-filter.html
 */
class BoolOr extends AbstractMulti
{
    /**
     * @return string
     */
    protected function _getBaseName() -> string
    {
        return "or";
    }
}