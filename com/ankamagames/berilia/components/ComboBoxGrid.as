package com.ankamagames.berilia.components
{
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
    import com.ankamagames.berilia.types.data.GridItem;
    import com.ankamagames.jerakine.utils.display.FrameIdManager;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.berilia.managers.UIEventManager;
    import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
    import com.ankamagames.jerakine.messages.Message;

    public class ComboBoxGrid extends Grid 
    {

        private var _lastMouseUpFrameId:int = -1;


        override public function process(msg:Message):Boolean
        {
            var _local_2:MouseMessage;
            var _local_3:GridItem;
            switch (true)
            {
                case (msg is MouseDoubleClickMessage):
                case (msg is MouseClickMessage):
                    if (this._lastMouseUpFrameId == FrameIdManager.frameId)
                    {
                        break;
                    };
                case (msg is MouseUpMessage):
                    this._lastMouseUpFrameId = FrameIdManager.frameId;
                    _local_2 = MouseMessage(msg);
                    _local_3 = super.getGridItem(_local_2.target);
                    if (_local_3)
                    {
                        if (!(_local_3.data))
                        {
                            if (UIEventManager.getInstance().isRegisteredInstance(this, SelectEmptyItemMessage))
                            {
                                super.dispatchMessage(new SelectEmptyItemMessage(this, SelectMethodEnum.CLICK));
                            };
                            setSelectedIndex(-1, SelectMethodEnum.CLICK);
                        };
                        setSelectedIndex(_local_3.index, SelectMethodEnum.CLICK);
                    };
                    return (true);
                default:
                    super.process(msg);
            };
            return (false);
        }


    }
}//package com.ankamagames.berilia.components

