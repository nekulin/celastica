namespace Elastica\Bulk\Action;

abstract class AbstractDocument extends \Elastica\Bulk\Action
{
    /**
     * @var \Elastica\Document|\Elastica\Script
     */
    protected _data;

    /**
     * @param \Elastica\Document|\Elastica\Script document
     */
    public function __construct(var document)
    {
        this->setData(document);
    }

    /**
     * @param \Elastica\Document document
     * @return \Elastica\Bulk\Action\AbstractDocument
     */
    public function setDocument(<\Elastica\Document> document) -> <\Elastica\Bulk\Action\AbstractDocument>
    {
        var metadata;
        let this->_data = document;

        let metadata = this->_getMetadataByDocument(document);

        this->setMetadata(metadata);

        return this;
    }

    /**
     * @param \Elastica\Script script
     * @return \Elastica\Bulk\Action\AbstractDocument
     */
    public function setScript(<\Elastica\Script> script) -> <\Elastica\Bulk\Action\AbstractDocument>
    {
        var metadata;

        if !(this instanceof \Elastica\Bulk\Action\UpdateDocument) {
            throw new \BadMethodCallException("setScript() can only be used for UpdateDocument");
        }

        let this->_data = script;

        let metadata = this->_getMetadataByScript(script);
        this->setMetadata(metadata);

        return this;
    }

    /**
     * @param \Elastica\Script|\Elastica\Document data
     * @throws \InvalidArgumentException
     * @return \Elastica\Bulk\Action\AbstractDocument
     */
    public function setData(var data) -> <\Elastica\Bulk\Action\AbstractDocument>
    {
        if data instanceof \Elastica\Script {
            this->setScript(data);
        } else {
            if data instanceof \Elastica\Document {
                this->setDocument(data);
            } else {
                throw new \InvalidArgumentException("Data should be a Document or a Script.");
            }
        }

        return this;
    }

    /**
     * Note: This is for backwards compatibility.
     * @return \Elastica\Document
     */
    public function getDocument() -> <\Elastica\Document>
    {
        return this->_data;
    }

    /**
     * Note: This is for backwards compatibility.
     * @return \Elastica\Script
     */
    public function getScript() -> <\Elastica\Script>
    {
        return this->_data;
    }

    /**
     * @return \Elastica\Document|\Elastica\Script
     */
    public function getData()
    {
        return this->_data;
    }

    /**
    * @param \Elastica\Document document
    * @return array
    */
    abstract protected function _getMetadataByDocument(<\Elastica\Document> document)
    {}


    /**
    * @param \Elastica\Script script
    * @return array
    */
    protected function _getMetadataByScript(<\Elastica\Script> script)
    {}

    /**
     * @param \Elastica\Document|\Elastica\Script data
     * @param string opType
     * @return \Elastica\Bulk\Action\AbstractDocument
     */
    public static function create(var data, var opType = null) -> <\Elastica\Bulk\Action\AbstractDocument>
    {
        var action;

    	//Check type
    	if !(data instanceof \Elastica\Document) && !(data instanceof \Elastica\Script) {
    		throw new \InvalidArgumentException("The data needs to be a Document or a Script.");
    	}

        if (null === opType && data->hasOpType()) {
            let opType = data->getOpType();
        }

        //Check that scripts can only be used for updates
        if (data instanceof \Elastica\Script) && (opType != \Elastica\Bulk\Action::OP_TYPE_UPDATE) {
            throw new \InvalidArgumentException("When performing an update action, the data needs to be a Document or a Script.");
        }

        switch (opType) {
            case \Elastica\Bulk\Action::OP_TYPE_DELETE:
                let action = new \Elastica\Bulk\Action\DeleteDocument(data);
                break;
            case \Elastica\Bulk\Action::OP_TYPE_CREATE:
                let action = new \Elastica\Bulk\Action\CreateDocument(data);
                break;
            case \Elastica\Bulk\Action::OP_TYPE_UPDATE:
                let action = new \Elastica\Bulk\Action\UpdateDocument(data);
                break;
            case \Elastica\Bulk\Action::OP_TYPE_INDEX:
            default:
                let action = new \Elastica\Bulk\Action\IndexDocument(data);
                break;
        }
        return action;
    }
}
