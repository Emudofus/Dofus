package com.ankamagames.berilia
{
    import com.ankamagames.jerakine.messages.*;

    public interface UIComponent extends MessageHandler
    {

        public function UIComponent();

        function remove() : void;

    }
}
