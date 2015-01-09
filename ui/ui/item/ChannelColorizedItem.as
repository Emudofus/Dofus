package ui.item
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ChatApi;
    import d2api.ConfigApi;
    import d2components.Texture;
    import d2components.Label;
    import flash.geom.ColorTransform;
    import d2hooks.*;

    public class ChannelColorizedItem 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var chatApi:ChatApi;
        public var configApi:ConfigApi;
        private var _data;
        private var _selected:Boolean;
        public var tx_color:Texture;
        public var lbl_colorChannel:Label;


        public function main(oParam:Object=null):void
        {
            this._data = oParam.data;
            this._selected = oParam.selected;
            this.update(this._data, this._selected);
        }

        public function unload():void
        {
        }

        public function get data()
        {
            return (this._data);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function update(data:*, selected:Boolean):void
        {
            var color:uint;
            var t:ColorTransform;
            this._data = data;
            if (data)
            {
                color = this.configApi.getConfigProperty("chat", ("channelColor" + data.id));
                t = new ColorTransform();
                t.color = color;
                this.tx_color.transform.colorTransform = t;
                this.lbl_colorChannel.text = data.name;
            };
        }

        public function select(selected:Boolean):void
        {
        }


    }
}//package ui.item

