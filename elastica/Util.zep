namespace Elastica;

/**
 * Elastica tools
 *
 * @category Xodoa
 * @package Elastica
 * @author Aris Kemper <aris.kemper@gmail.com>
 */
class Util
{
    /**
    * Replace the following reserved words: AND OR NOT
    * and
    * escapes the following terms: + - && || ! ( ) { } [ ] ^ " ~ * ? : \
    *
    * @param  string $term Query term to replace and escape
    * @return string Replaced and escaped query term
    * @link http://lucene.apache.org/java/2_4_0/queryparsersyntax.html#Boolean%20operators
    * @link http://lucene.apache.org/java/2_4_0/queryparsersyntax.html#Escaping%20Special%20Characters
    */
    public static function replaceBooleanWordsAndEscapeTerm(string term) -> string
    {
        return self::escapeTerm(self::replaceBooleanWords(term));
    }

    /**
    * Escapes the following terms (because part of the query language)
    * + - && || ! ( ) { } [ ] ^ " ~ * ? : \
    *
    * @param  string $term Query term to escape
    * @return string Escaped query term
    * @link http://lucene.apache.org/java/2_4_0/queryparsersyntax.html#Escaping%20Special%20Characters
    */

    public static function escapeTerm(string term) -> string
    {
        var pattern = '/(+|-|&&||||!|(|)|{|}|[|]|^|"|~|*|?|:|/|)/';
        return preg_replace(pattern, "$1", term);
    }

    /**
    * Replace the following reserved words (because part of the query language)
    * AND OR NOT
    *
    * @param  string $term Query term to replace
    * @return string Replaced query term
    * @link http://lucene.apache.org/java/2_4_0/queryparsersyntax.html#Boolean%20operators
    */
    public static function replaceBooleanWords(string term) -> string
    {
        var replacementMap = ["AND": "&&", "OR": "||", "NOT": "!"];
        return strtr(term, replacementMap);
    }

    /**
    * Converts a snake_case string to CamelCase
    *
    * For example: hello_world to HelloWorld
    *
    * @param  string $string snake_case string
    * @return string CamelCase string
    */
    public static function toCamelCase(string snakeCase) -> string
    {
        return str_replace(" ", "", ucwords(str_replace("_", " ", snakeCase)));
    }

    /**
    * Converts a CamelCase string to snake_case
    *
    * For Example HelloWorld to hello_world
    *
    * @param  string $string CamelCase String to Convert
    * @return string SnakeCase string
    */
    public static function toSnakeCase(string camelCase) -> string
    {
        return (substr(preg_replace("/([A-Z])/", "_$1", camelCase), 1))->lower();
    }

    /**
    * Converts given time to format: 1995-12-31T23:59:59Z
    *
    * This is the lucene date format
    *
    * @param  int    $date Date input (could be string etc.) -> must be supported by strtotime
    * @return string Converted date string
    */
    public static function convertDate(var dateInput)
    {
        if is_int(dateInput) {
            return date("Y-m-dTH:i:sZ", dateInput);
        } else {
            return date("Y-m-dTH:i:sZ", strtotime(dateInput));
        }
    }

    /**
     * Tries to guess the name of the param, based on its class
     * Exemple: \Elastica\Filter\HasChildFilter => has_child
     *
     * @param string|object Class or Class name
     * @return string parameter name
     */
    public static function getParamName(var objClass)
    {/*
        var last;
        let parts = [];

        var cls;

        if is_object(objClass) {
            cls = get_class(objClass);
        } else {
            cls = objClass;
        }

        parts = explode('\\', cls);
        last  = preg_replace('/(Facet|Query|Filter)$/', '', array_pop(parts));
        return self::toSnakeCase(last);*/
    }

    /**
    * Converts Request to Curl console command
    *
    * @param Request $request
    * @return string
    */

    public static function convertRequestToCurlCommand(var request) -> string
    {

        var message = "";
        /*
        if is_object(request) {
            var req = request->getMethod()->upper();
            var reqUpper = req->upper();
            message = 'curl -X' . reqUpper . ' ';
            message .= '\'http://' . request->getConnection()->getHost() . ':' . request->getConnection()->getPort() . '/';
            message .= request->getPath();

            query = request->getQuery();
            if (!empty(query)) {
                message .= '?' . http_build_query(query);
            }

            message .= '\'';

            data = request->getData();
            if (!empty(data)) {
                message .= ' -d \'' . json_encode(data) . '\'';
            }
        }*/
        return message;
    }
}
