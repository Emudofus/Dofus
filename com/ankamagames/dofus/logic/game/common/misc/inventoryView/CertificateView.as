package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class CertificateView extends Object implements IInventoryView
    {
        private var _content:Vector.<ItemWrapper>;
        private var _hookLock:HookLock;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CertificateView));

        public function CertificateView(param1:HookLock)
        {
            this._hookLock = param1;
            return;
        }// end function

        public function initialize(param1:Vector.<ItemWrapper>) : void
        {
            var _loc_2:ItemWrapper = null;
            this._content = new Vector.<ItemWrapper>;
            for each (_loc_2 in param1)
            {
                
                if (this.isListening(_loc_2))
                {
                    this.addItem(_loc_2, 0);
                }
            }
            return;
        }// end function

        public function get name() : String
        {
            return "certificate";
        }// end function

        public function get content() : Vector.<ItemWrapper>
        {
            return this._content;
        }// end function

        public function addItem(param1:ItemWrapper, param2:int) : void
        {
            this._content.unshift(param1);
            this.updateView();
            return;
        }// end function

        public function removeItem(param1:ItemWrapper, param2:int) : void
        {
            var _loc_3:* = this.content.indexOf(param1);
            if (_loc_3 == -1)
            {
                _log.warn("L\'item qui doit être supprimé n\'est pas présent dans la liste");
                return;
            }
            this.content.splice(_loc_3, 1);
            this.updateView();
            return;
        }// end function

        public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void
        {
            this.updateView();
            return;
        }// end function

        public function isListening(param1:ItemWrapper) : Boolean
        {
            return param1.isCertificate;
        }// end function

        public function updateView() : void
        {
            this._hookLock.addHook(MountHookList.MountStableUpdate, [null, null, this.content]);
            return;
        }// end function

        public function empty() : void
        {
            this._content = new Vector.<ItemWrapper>;
            this.updateView();
            return;
        }// end function

    }
}
