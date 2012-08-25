package 
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;

    class RenderQueueItem extends Object
    {
        public var container:UiRootContainer;
        public var properties:Object;
        public var uiData:UiData;

        function RenderQueueItem(param1:UiData, param2:UiRootContainer, param3)
        {
            this.container = param2;
            this.properties = param3;
            this.uiData = param1;
            UiRenderManager.MEMORY_LOG[this] = 1;
            return;
        }// end function

    }
}
