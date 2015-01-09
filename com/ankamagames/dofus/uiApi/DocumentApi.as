package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.documents.Document;

    [InstanciedApi]
    public class DocumentApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;

        public function DocumentApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(DocumentApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function getDocument(pDocId:uint):Object
        {
            return (Document.getDocumentById(pDocId));
        }

        [Untrusted]
        public function getType(pDocId:uint):uint
        {
            return (Document.getDocumentById(pDocId).typeId);
        }


    }
}//package com.ankamagames.dofus.uiApi

