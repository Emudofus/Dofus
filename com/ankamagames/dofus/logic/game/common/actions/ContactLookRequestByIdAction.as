package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ContactLookRequestByIdAction implements Action 
    {

        private var _contactType:uint;
        private var _entityId:uint;


        public static function create(pContactType:uint, pEntityId:uint):ContactLookRequestByIdAction
        {
            var clrbia:ContactLookRequestByIdAction = new (ContactLookRequestByIdAction)();
            clrbia._contactType = pContactType;
            clrbia._entityId = pEntityId;
            return (clrbia);
        }


        public function get contactType():uint
        {
            return (this._contactType);
        }

        public function get entityId():uint
        {
            return (this._entityId);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

