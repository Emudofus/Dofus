package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.documents.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class DocumentApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function DocumentApi()
        {
            this._log = Log.getLogger(getQualifiedClassName());
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getDocument(param1:uint) : Object
        {
            return Document.getDocumentById(param1);
        }// end function

        public function getType(param1:uint) : uint
        {
            return Document.getDocumentById(param1).typeId;
        }// end function

    }
}
