package blocks
{
    import d2data.DelayedActionItem;
    import d2data.Item;
    import d2enums.DelayedActionTypeEnum;
    import d2hooks.*;

    public class DelayedActionTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _iconUrl:String;
        private var _data:DelayedActionItem;

        public function DelayedActionTooltipBlock(data:DelayedActionItem)
        {
            var _local_2:Item;
            super();
            this._data = data;
            switch (data.type)
            {
                case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
                    _local_2 = Api.data.getItem(data.dataId);
                    if (_local_2)
                    {
                        this._iconUrl = (("[config.gfx.path.item.bitmap]" + _local_2.iconId) + ".png");
                    };
                    break;
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/world/delayedAction.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            var uri:String;
            var backgroundName:String;
            switch (this._data.type)
            {
                case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
                    backgroundName = "[local.assets]delayedItemUse";
                    break;
            };
            this._content = this._block.getChunk("content").processContent({
                "uri":this._iconUrl,
                "backName":backgroundName
            });
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }


    }
}//package blocks

