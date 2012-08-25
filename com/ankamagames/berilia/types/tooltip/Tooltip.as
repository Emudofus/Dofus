package com.ankamagames.berilia.types.tooltip
{
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;
    import flash.utils.*;

    public class Tooltip extends Object
    {
        protected var _log:Logger;
        private var _mainblock:TooltipBlock;
        private var _blocks:Array;
        private var _loadedblock:uint = 0;
        private var _mainblockLoaded:Boolean = false;
        private var _callbacks:Array;
        private var _content:String = "";
        private var _useSeparator:Boolean = true;
        public var uiModuleName:String;
        public var scriptClass:Class;
        public var makerName:String;
        public var display:UiRootContainer;
        public var strata:int = 4;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function Tooltip(param1:Uri, param2:Uri, param3:Uri = null)
        {
            this._log = Log.getLogger(getQualifiedClassName(Tooltip));
            this._callbacks = new Array();
            if (param1 == null && param2 == null)
            {
                return;
            }
            this._blocks = new Array();
            this._mainblock = new TooltipBlock();
            this._mainblock.addEventListener(Event.COMPLETE, this.onMainChunkLoaded);
            if (!param3)
            {
                this._useSeparator = false;
                this._mainblock.initChunk([new ChunkData("main", param1), new ChunkData("container", param2)]);
            }
            else
            {
                this._mainblock.initChunk([new ChunkData("main", param1), new ChunkData("separator", param3), new ChunkData("container", param2)]);
            }
            this._mainblock.init();
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get mainBlock() : TooltipBlock
        {
            return this._mainblock;
        }// end function

        public function addBlock(param1:TooltipBlock) : void
        {
            this._blocks.push(param1);
            param1.addEventListener(Event.COMPLETE, this.onChunkReady);
            param1.init();
            return;
        }// end function

        public function get content() : String
        {
            return this._content;
        }// end function

        public function askTooltip(param1:Callback) : void
        {
            this._callbacks.push(param1);
            this.processCallback();
            return;
        }// end function

        public function update(param1:String) : void
        {
            this.processCallback();
            return;
        }// end function

        private function onMainChunkLoaded(event:Event) : void
        {
            this._mainblockLoaded = true;
            this.processCallback();
            return;
        }// end function

        private function processCallback() : void
        {
            if (this._mainblockLoaded && this._loadedblock == this._blocks.length)
            {
                this.makeTooltip();
                while (this._callbacks.length)
                {
                    
                    Callback(this._callbacks.pop()).exec();
                }
            }
            return;
        }// end function

        private function makeTooltip() : void
        {
            var _loc_2:TooltipBlock = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._blocks)
            {
                
                if (_loc_2.content && _loc_2.content.length)
                {
                    _loc_1.push(this._mainblock.getChunk("container").processContent({content:_loc_2.content}));
                }
            }
            if (this._useSeparator)
            {
                this._content = this._mainblock.getChunk("main").processContent({content:_loc_1.join(this._mainblock.getChunk("separator").processContent(null))});
            }
            else
            {
                this._content = this._mainblock.getChunk("main").processContent({content:_loc_1.join("")});
            }
            return;
        }// end function

        private function onChunkReady(event:Event) : void
        {
            var _loc_2:String = this;
            var _loc_3:* = this._loadedblock + 1;
            _loc_2._loadedblock = _loc_3;
            this.processCallback();
            return;
        }// end function

    }
}
