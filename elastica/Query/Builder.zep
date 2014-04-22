namespace Elastica\Query;

/**
 * Query Builder.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/
 **/
class Builder extends AbstractQuery
{
    /**
     * Query string.
     *
     * @var string
     */
    private _string = "{";

    /**
     * Factory method.
     *
     * @param string string JSON encoded string to use as query.
     *
     * @return \Elastica\Query\Builder
     */
    public static function factory(string str = null) -> <\Elastica\Query\Builder>
    {
        return new \Elastica\Query\Builder(str);
    }

    /**
     * Constructor
     *
     * @param string string JSON encoded string to use as query.
     */
    public function __construct(var str = null)
    {
        if !str == null {
            let this->_string .= substr(str, 1, -1);
        }
    }

    /**
     * Output the query string.
     *
     * @return string
     */
    public function __toString() -> string
    {
        return rtrim(this->_string, ",")."}";
    }

    /**
     * {@inheritdoc}
     */
    public function toArray() -> array
    {
        var arr;
        let arr = json_decode(this->__toString(), true);

        if arr == null {
            throw new \Elastica\Exception\InvalidException("The query produced is invalid");
        }

        return arr;
    }

    /**
     * Allow wildcards (*, ?) as the first character in a query.
     *
     * @param boolean enable Defaults to true.
     *
     * @return \Elastica\Query\Builder
     */
    public function allowLeadingWildcard(boolean enable = true) -> <\Elastica\Query\Builder>
    {
        return this->field("allow_leading_wildcard", enable);
    }

    /**
     * Enable best effort analysis of wildcard terms.
     *
     * @param boolean bool Defaults to true.
     *
     * @return \Elastica\Query\Builder
     */
    public function analyzeWildcard(boolean enable = true) -> <\Elastica\Query\Builder>
    {
        return this->field("analyze_wildcard", enable);
    }

    /**
     * Set the analyzer name used to analyze the query string.
     *
     * @param string analyzer Analyzer to use.
     *
     * @return \Elastica\Query\Builder
     */
    public function analyzer(string analyzer) -> <\Elastica\Query\Builder>
    {
        return this->field("analyzer", analyzer);
    }

    /**
     * Autogenerate phrase queries.
     *
     * @param boolean bool Defaults to true.
     *
     * @return \Elastica\Query\Builder
     */
    public function autoGeneratePhraseQueries(boolean enable = true) -> <\Elastica\Query\Builder>
    {
        return this->field("auto_generate_phrase_queries", enable);
    }

    /**
     * Bool Query.
     *
     * A query that matches documents matching boolean combinations of other queries.
     *
     * The bool query maps to Lucene BooleanQuery.
     *
     * It is built using one or more boolean clauses, each clause with a typed
     * occurrence.
     *
     * The occurrence types are: must, should, must_not.
     *
     * @return \Elastica\Query\Builder
     */
    public function boolQuery() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("bool");
    }

    /**
     * Close a "bool" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function boolClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Sets the boost value of the query.
     *
     * @param float boost Defaults to 1.0.
     *
     * @return \Elastica\Query\Builder
     */
    public function boost(var boost = 1.0) -> <\Elastica\Query\Builder>
    {
        return this->field("boost", (float) boost);
    }

    /**
     * Close a previously opened brace.
     *
     * @return \Elastica\Query\Builder
     */
    public function close() -> <\Elastica\Query\Builder>
    {
        let this->_string = rtrim(this->_string, " ,")."},";

        return this;
    }

    /**
     * Constant Score Query.
     *
     * A query that wraps a filter or another query and simply returns a constant
     * score equal to the query boost for every document in the filter.
     *
     * Maps to Lucene ConstantScoreQuery.
     *
     * @return \Elastica\Query\Builder
     */
    public function constantScore() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("constant_score");
    }

    /**
     * Close a "constant_score" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function constantScoreClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * The default field for query terms if no prefix field is specified.
     *
     * @param string field Defaults to _all.
     *
     * @return \Elastica\Query\Builder
     */
    public function defaultField(string field = "_all") -> <\Elastica\Query\Builder>
    {
        return this->field("default_field", field);
    }

    /**
     * The default operator used if no explicit operator is specified.
     *
     * For example, with a default operator of OR, the query "capital of Hungary"
     * is translated to "capital OR of OR Hungary", and with default operator of
     * AND, the same query is translated to "capital AND of AND Hungary".
     *
     * @param string operator Defaults to OR.
     *
     * @return \Elastica\Query\Builder
     */
    public function defaultOperator(string operator = "OR") -> <\Elastica\Query\Builder>
    {
        return this->field("default_operator", operator);
    }

    /**
     * Dis Max Query.
     *
     * A query that generates the union of documents produced by its subqueries,
     * and that scores each document with the maximum score for that document as
     * produced by any subquery, plus a tie breaking increment for any additional
     * matching subqueries.
     *
     * @return \Elastica\Query\Builder
     */
    public function disMax() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("dis_max");
    }

    /**
     * Close a "dis_max" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function disMaxClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Enable position increments in result queries.
     *
     * @param boolean bool Defaults to true.
     *
     * @return \Elastica\Query\Builder
     */
    public function enablePositionIncrements(boolean enable = true) -> <\Elastica\Query\Builder>
    {
        return this->field("enable_position_increments", enable);
    }

    /**
     * Enables explanation for each hit on how its score was computed.
     *
     * @param boolean value Turn on / off explain.
     *
     * @return \Elastica\Query\Builder
     */
    public function explain(boolean value = true) -> <\Elastica\Query\Builder>
    {
        return this->field("explain", value);
    }

    /**
     * Open "facets" block.
     *
     * Facets provide aggregated data based on a search query.
     *
     * In the simple case, a facet can return facet counts for various facet
     * values for a specific field.
     *
     * ElasticSearch supports more advanced facet implementations, such as
     * statistical or date histogram facets.
     *
     * @return \Elastica\Query\Builder
     */
    public function facets() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("facets");
    }

    /**
     * Close a facets block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function facetsClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     * Add a specific field / value entry.
     *
     * @param string name  Field to add.
     * @param mixed  value Value to set.
     *
     * @return \Elastica\Query\Builder
     */
    public function field(string name, var value) -> <\Elastica\Query\Builder>
    {
        if typeof value == "boolean" {
            let value = "". var_export(value, true) . "";
        } else {
            if typeof value == "array" {
                let value = "[" . implode("","", value) . "]";
            } else {
                let value = "" . value . "";
            }
        }

        let this->_string .= "" . name . ":" . value . ",";

        return this;
    }

    /**
     * Close a field block.
     *
     * Alias of close() for ease of reading in source.
     * Passed parameters will be ignored, however they can be useful in source for
     * seeing which field is being closed.
     *
     * Builder::factory()
     *     ->query()
     *     ->range()
     *     ->fieldOpen("created")
     *     ->gte("2011-07-18 00:00:00")
     *     ->lt("2011-07-19 00:00:00")
     *     ->fieldClose("created")
     *     ->rangeClose()
     *     ->queryClose();
     *
     * @return \Elastica\Query\Builder
     */
    public function fieldClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     * Open a node for the specified name.
     *
     * @param string name Field name.
     *
     * @return \Elastica\Query\Builder
     */
    public function fieldOpen(string name) -> <\Elastica\Query\Builder>
    {
        let this->_string .= "" . name . ":";
        this->open();

        return this;
    }

    /**
     * Explicitly define fields to return.
     *
     * @param array fields Array of fields to return.
     *
     * @return \Elastica\Query\Builder
     */
    public function fields(var fields = []) -> <\Elastica\Query\Builder>
    {
        var field;
        let this->_string .= "fields:[";

        for field in fields {
            let this->_string .= "" . field . ",";
        }

        let this->_string = rtrim(this->_string, ",")."],";

        return this;
    }

    /**
     * Open a "filter" block.
     *
     * @return \Elastica\Query\Builder
     */
    public function filter() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("filter");
    }

    /**
     * Close a filter block.
     *
     * @return \Elastica\Query\Builder
     */
    public function filterClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     *  Query.
     *
     * @return \Elastica\Query\Builder
     */
    public function filteredQuery() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("filtered");
    }

    /**
     * Close a "filtered_query" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function filteredQueryClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Set the from parameter (offset).
     *
     * @param integer value Result number to start from.
     *
     * @return \Elastica\Query\Builder
     */
    public function from(int value = 0) -> <\Elastica\Query\Builder>
    {
        return this->field("from", value);
    }

    /**
     * Set the minimum similarity for fuzzy queries.
     *
     * @param float value Defaults to 0.5.
     *
     * @return \Elastica\Query\Builder
     */
    public function fuzzyMinSim(value = 0.5) -> <\Elastica\Query\Builder>
    {
        return this->field("fuzzy_min_sim", (float) value);
    }

    /**
     * Set the prefix length for fuzzy queries.
     *
     * @param integer value Defaults to 0.
     *
     * @return \Elastica\Query\Builder
     */
    public function fuzzyPrefixLength(int value = 0) -> <\Elastica\Query\Builder>
    {
        return this->field("fuzzy_prefix_length", value);
    }

    /**
     * Add a greater than (gt) clause.
     *
     * Used in range blocks.
     *
     * @param mixed value Value to be gt.
     *
     * @return \Elastica\Query\Builder
     */
    public function gt(value) -> <\Elastica\Query\Builder>
    {
        return this->field("gt", value);
    }

    /**
     * Add a greater than or equal to (gte) clause.
     *
     * Used in range blocks.
     *
     * @param mixed value Value to be gte to.
     *
     * @return \Elastica\Query\Builder
     */
    public function gte(var value) -> <\Elastica\Query\Builder>
    {
        return this->field("gte", value);
    }

    /**
     * Automatically lower-case terms of wildcard, prefix, fuzzy, and range queries.
     *
     * @param boolean bool Defaults to true.
     *
     * @return \Elastica\Query\Builder
     */
    public function lowercaseExpandedTerms(boolean enable = true) -> <\Elastica\Query\Builder>
    {
        return this->field("lowercase_expanded_terms", enable);
    }

    /**
     * Add a less than (lt) clause.
     *
     * Used in range blocks.
     *
     * @param mixed value Value to be lt.
     *
     * @return \Elastica\Query\Builder
     */
    public function lt(var value) -> <\Elastica\Query\Builder>
    {
        return this->field("lt", value);
    }

    /**
     * Add a less than or equal to (lte) clause.
     *
     * Used in range blocks.
     *
     * @param mixed value Value to be lte to.
     *
     * @return \Elastica\Query\Builder
     */
    public function lte(value) -> <\Elastica\Query\Builder>
    {
        return this->field("lte", value);
    }

    /**
     * Match All Query.
     *
     * A query that matches all documents.
     *
     * Maps to Lucene MatchAllDocsQuery.
     *
     * @param float boost Boost to use.
     *
     * @return \Elastica\Query\Builder
     */
    public function matchAll(boost = null) -> <\Elastica\Query\Builder>
    {
        this->fieldOpen("match_all");

        if boost != null && is_numeric(boost) {
            this->field("boost", (float) boost);
        }

        return this->close();
    }

    /**
     * The minimum number of should clauses to match.
     *
     * @param integer minimum Minimum number that should match.
     *
     * @return \Elastica\Query\Builder
     */
    public function minimumNumberShouldMatch(int minimum) -> <\Elastica\Query\Builder>
    {
        return this->field("minimum_number_should_match", (int) minimum);
    }

    /**
     * The clause (query) must appear in matching documents.
     *
     * @return \Elastica\Query\Builder
     */
    public function must() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("must");
    }

    /**
     * Close a "must" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function mustClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * The clause (query) must not appear in the matching documents.
     *
     * Note that it is not possible to search on documents that only consists of
     * a must_not clauses.
     *
     * @return \Elastica\Query\Builder
     */
    public function mustNot() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("must_not");
    }

    /**
     * Close a "must_not" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function mustNotClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Add an opening brace.
     *
     * @return \Elastica\Query\Builder
     */
    public function open() -> <\Elastica\Query\Builder>
    {
        let this->_string .= "{";

        return this;
    }

    /**
     * Sets the default slop for phrases.
     *
     * If zero, then exact phrase matches are required.
     *
     * @param integer value Defaults to 0.
     *
     * @return \Elastica\Query\Builder
     */
    public function phraseSlop(int value = 0) -> <\Elastica\Query\Builder>
    {
        return this->field("phrase_slop", (int) value);
    }

    /**
     *  Query.
     *
     * @return \Elastica\Query\Builder
     */
    public function prefix() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("prefix");
    }

    /**
     * Close a "prefix" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function prefixClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Queries to run within a dis_max query.
     *
     * @param array queries Array of queries.
     *
     * @return \Elastica\Query\Builder
     */
    public function queries(var queries = []) -> <\Elastica\Query\Builder>
    {
        var query;

        let this->_string .= "queries:[";

        for query in queries {
            let this->_string .= query . ",";
        }

        let this->_string = rtrim(this->_string, " ,")."],";

        return this;
    }

    /**
     * Open a query block.
     *
     * @return \Elastica\Query\Builder
     */
    public function query() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("query");
    }

    /**
     * Close a query block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function queryClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     * Query String Query.
     *
     * A query that uses a query parser in order to parse its content
     *
     * @return \Elastica\Query\Builder
     */
    public function queryString() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("query_string");
    }

    /**
     * Close a "query_string" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function queryStringClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Open a range block.
     *
     * @return \Elastica\Query\Builder
     */
    public function range() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("range");
    }

    /**
     * Close a range block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function rangeClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     * The clause (query) should appear in the matching document.
     *
     * A boolean query with no must clauses, one or more should clauses must
     * match a document.
     *
     * @return \Elastica\Query\Builder
     */
    public function should() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("should");
    }

    /**
     * Close a "should" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function shouldClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Set the size parameter (number of records to return).
     *
     * @param integer value Number of records to return.
     *
     * @return \Elastica\Query\Builder
     */
    public function size(int value = 10) -> <\Elastica\Query\Builder>
    {
        return this->field("size", value);
    }

    /**
     * Allows to add one or more sort on specific fields.
     *
     * @return \Elastica\Query\Builder
     */
    public function sort() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("sort");
    }

    /**
     * Close a sort block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function sortClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     * Add a field to sort on.
     *
     * @param string  name    Field to sort.
     * @param boolean reverse Reverse direction.
     *
     * @return \Elastica\Query\Builder
     */
    public function sortField(string name, boolean rev = false) -> <\Elastica\Query\Builder>
    {
        return this
            ->fieldOpen("sort")
            ->fieldOpen(name)
            ->field("reverse", rev)
            ->close()
            ->close();
    }

    /**
     * Sort on multiple fields
     *
     * @param array fields Associative array where the keys are field names to sort on, and the
     *                      values are the sort order: "asc" or "desc"
     *
     * @return \Elastica\Query\Builder
     */
    public function sortFields(var fields = []) -> <\Elastica\Query\Builder>
    {
        var fieldName, order;

        let this->_string .= "sort:[";

        for fieldName, order in fields {
            let this->_string .= "{" . fieldName . ":" . order . "},";
        }

        let this->_string = rtrim(this->_string, ",") . "],";

        return this;
    }

    /**
     * Term Query.
     *
     * Matches documents that have fields that contain a term (not analyzed).
     *
     * The term query maps to Lucene TermQuery.
     *
     * @return \Elastica\Query\Builder
     */
    public function term() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("term");
    }

    /**
     * Close a "term" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function termClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }

    /**
     * Open a "text_phrase" block.
     *
     * @return \Elastica\Query\Builder
     */
    public function textPhrase() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("text_phrase");
    }

    /**
     * Close a "text_phrase" block.
     *
     * @return \Elastica\Query\Builder
     */
    public function textPhraseClose() -> <\Elastica\Query\Builder>
    {
        return this->close();
    }

    /**
     * When using dis_max, the disjunction max tie breaker.
     *
     * @param float multiplier Multiplier to use.
     *
     * @return \Elastica\Query\Builder
     */
    public function tieBreakerMultiplier(var multiplier) -> <\Elastica\Query\Builder>
    {
        return this->field("tie_breaker_multiplier", (float) multiplier);
    }

    /**
     *  Query.
     *
     * @return \Elastica\Query\Builder
     */
    public function wildcard() -> <\Elastica\Query\Builder>
    {
        return this->fieldOpen("wildcard");
    }

    /**
     * Close a "wildcard" block.
     *
     * Alias of close() for ease of reading in source.
     *
     * @return \Elastica\Query\Builder
     */
    public function wildcardClose() -> <\Elastica\Query\Builder>
    {
        return this->fieldClose();
    }
}