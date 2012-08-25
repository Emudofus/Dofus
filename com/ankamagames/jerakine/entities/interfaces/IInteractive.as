package com.ankamagames.jerakine.entities.interfaces
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.tubul.interfaces.*;

    public interface IInteractive extends IEventDispatcher, IEntity
    {

        public function IInteractive();

        function get handler() : MessageHandler;

        function get useHandCursor() : Boolean;

        function get enabledInteractions() : uint;

    }
}
