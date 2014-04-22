namespace Elastica\Transport;

/**
 * Elastica Http Transport object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Http extends AbstractTransport
{
    /**
     * Http scheme
     *
     * @var string Http scheme
     */
    protected _scheme = "http";

    /**
     * Curl resource to reuse
     *
     * @var resource Curl resource to reuse
     */
    protected static _curlConnection = null;

    /**
     * Makes calls to the elasticsearch server
     *
     * All calls that are made to the server are done through this function
     *
     * @param  \Elastica\Request request
     * @param  array params Host, Port, ...
     * @throws \Elastica\Exception\ConnectionException
     * @throws \Elastica\Exception\ResponseException
     * @throws \Elastica\Exception\Connection\HttpException
     * @return \Elastica\Response                    Response object
     */
    public function exec(<\Elastica\Request> request, array params) -> <\Elastica\Response>
    {
        var connection, conn, url, baseUri, query, proxy,
            headersConfig, header, headers, data,  httpMethod, content,
            start, end, responseString, errorNumber, response;

        let connection = this->getConnection();

        let conn = this->_getConnection(connection->isPersistent());

        // If url is set, url is taken. Otherwise port, host and path
        let url = connection->hasConfig("url") ? connection->getConfig("url") : "";

        if !empty url {
            let baseUri = url;
        } else {
            let baseUri = this->_scheme . "://" . connection->getHost() . ":" . connection->getPort() . "/" . connection->getPath();
        }

        let baseUri .= request->getPath();

        let query = request->getQuery();

        if !empty query {
            let baseUri .= "?" . http_build_query(query);
        }

        curl_setopt(conn, CURLOPT_URL, baseUri);
        curl_setopt(conn, CURLOPT_TIMEOUT, connection->getTimeout());
        curl_setopt(conn, CURLOPT_FORBID_REUSE, 0);

        let proxy = connection->getProxy();
        if proxy != null {
            curl_setopt(conn, CURLOPT_PROXY, proxy);
        }

        this->_setupCurl(conn);

        let headersConfig = connection->hasConfig("headers") ? connection->getConfig("headers") : [];

        if !empty headersConfig {
            let headers = [];
            /*todo
            while (list(header, headerValue) = each(headersConfig)) {
                array_push(headers, header . ": " . headerValue);
            }*/

            curl_setopt(conn, CURLOPT_HTTPHEADER, headers);
        }

        // TODO: REFACTOR
        let data = request->getData();
        let httpMethod = request->getMethod();

        if !empty data {
            if (this->hasParam("postWithRequestBody") && this->getParam("postWithRequestBody") == true) {
                let httpMethod = \Elastica\Request::POST;
            }

            if typeof data == "array" {
                let content = json_encode(data);
            } else {
                let content = data;
            }

            // Escaping of / not necessary. Causes problems in base64 encoding of files
            let content = str_replace("\/", "/", content);

            curl_setopt(conn, CURLOPT_POSTFIELDS, content);
        }

        curl_setopt(conn, CURLOPT_NOBODY, httpMethod == "HEAD");

        curl_setopt(conn, CURLOPT_CUSTOMREQUEST, httpMethod);

        if defined("DEBUG") && DEBUG {
            // Track request headers when in debug mode
            curl_setopt(conn, CURLINFO_HEADER_OUT, true);
        }

        let start = microtime(true);

        // cURL opt returntransfer leaks memory, therefore OB instead.
        ob_start();
        curl_exec(conn);
        let responseString = ob_get_clean();

        let end = microtime(true);

        // Checks if error exists
        let errorNumber = curl_errno(conn);

        let response = new \Elastica\Response(responseString, curl_getinfo(this->_getConnection(), CURLINFO_HTTP_CODE));

        if defined("DEBUG") && DEBUG {
            response->setQueryTime(end - start);
        }

        response->setTransferInfo(curl_getinfo(conn));


        if response->hasError() {
            throw new \Elastica\Exception\ResponseException(request, response);
        }

        if errorNumber > 0 {
            throw new \Elastica\Exception\HttpException(errorNumber, request, response);
        }

        return response;
    }

    /**
     * Called to add additional curl params
     *
     * @param resource curlConnection Curl connection
     */
    protected function _setupCurl(curlConnection)
    {
        var key, param;
        if this->getConnection()->hasConfig("curl") {
            for key, param in this->getConnection()->getConfig("curl") {
                curl_setopt(curlConnection, key, param);
            }
        }
    }

    /**
     * Return Curl resource
     *
     * @param  bool persistent False if not persistent connection
     * @return resource Connection resource
     */
    protected function _getConnection(boolean persistent = true)
    {
        if !persistent || !self::_curlConnection {
            let self::_curlConnection = curl_init();
        }

        return self::_curlConnection;
    }
}