namespace Elastica\Transport;

/**
 * Elastica Memcache Transport object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Memcache extends AbstractTransport
{
    /**
     * Makes calls to the elasticsearch server
     *
     * @param \Elastica\Request request
     * @param  array                               params Host, Port, ...
     * @throws \Elastica\Exception\ResponseException
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Response                   Response object
     */
    public function exec(<\Elastica\Request> request, array params) -> <\Elastica\Response>
    {
        var memcache, func, data, content = "", responseString, response;

        let memcache = new \Memcache();
        memcache->connect(this->getConnection()->getHost(), this->getConnection()->getPort());

        // Finds right function name
        let func = strtolower(request->getMethod());
        let data = request->getData();

        if !empty data {
            if typeof data == "array" {
                let content = json_encode(data);
            } else {
                let content = data;
            }

            // Escaping of / not necessary. Causes problems in base64 encoding of files
            let content = str_replace("\/", "/", content);
        }

        let responseString = "";

        switch (func) {
            case "post":
            case "put":
                memcache->set(request->getPath(), content);
                break;
            case "get":
                let responseString = memcache->get(request->getPath() . "?source=" . content);
                echo responseString . PHP_EOL;
                break;
            case "delete":
                break;
            default:
                throw new \Elastica\Exception\InvalidException("Method " . func . " is not supported in memcache transport");

        }

        let response = new \Elastica\Response(responseString);

        if response->hasError() {
            throw new \Elastica\Exception\ResponseException(request, response);
        }

        return response;
    }
}