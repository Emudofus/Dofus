package com.ankamagames.dofus.logic.game.roleplay.messages
{
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;

    public class InteractiveElementMouseOutMessage implements Message 
    {

        private var _ie:InteractiveElement;

        public function InteractiveElementMouseOutMessage(ie:InteractiveElement)
        {
            this._ie = ie;
        }

        public function get interactiveElement():InteractiveElement
        {
            return (this._ie);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.messages

