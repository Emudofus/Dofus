package com.ankamagames.berilia.types.tooltip
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.ChunkData;
   
   public class Tooltip extends Object
   {
      
      public function Tooltip(param1:Uri, param2:Uri, param3:Uri=null) {
         this._log = Log.getLogger(getQualifiedClassName(Tooltip));
         this._callbacks = new Array();
         super();
         if(param1 == null && param2 == null)
         {
            return;
         }
         this._blocks = new Array();
         this._mainblock = new TooltipBlock();
         this._mainblock.addEventListener(Event.COMPLETE,this.onMainChunkLoaded);
         if(!param3)
         {
            this._useSeparator = false;
            this._mainblock.initChunk([new ChunkData("main",param1),new ChunkData("container",param2)]);
         }
         else
         {
            this._mainblock.initChunk([new ChunkData("main",param1),new ChunkData("separator",param3),new ChunkData("container",param2)]);
         }
         this._mainblock.init();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
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
      
      public var mustBeHidden:Boolean = true;
      
      public var strata:int = 4;
      
      public function get mainBlock() : TooltipBlock {
         return this._mainblock;
      }
      
      public function addBlock(param1:TooltipBlock) : void {
         this._blocks.push(param1);
         param1.addEventListener(Event.COMPLETE,this.onChunkReady);
         param1.init();
      }
      
      public function get content() : String {
         return this._content;
      }
      
      public function askTooltip(param1:Callback) : void {
         this._callbacks.push(param1);
         this.processCallback();
      }
      
      public function update(param1:String) : void {
         this.processCallback();
      }
      
      private function onMainChunkLoaded(param1:Event) : void {
         this._mainblockLoaded = true;
         this.processCallback();
      }
      
      private function processCallback() : void {
         if((this._mainblockLoaded) && this._loadedblock == this._blocks.length)
         {
            this.makeTooltip();
            while(this._callbacks.length)
            {
               Callback(this._callbacks.pop()).exec();
            }
         }
      }
      
      private function makeTooltip() : void {
         var _loc2_:TooltipBlock = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in this._blocks)
         {
            if((_loc2_.content) && (_loc2_.content.length))
            {
               _loc1_.push(this._mainblock.getChunk("container").processContent({"content":_loc2_.content}));
            }
         }
         if(this._useSeparator)
         {
            this._content = this._mainblock.getChunk("main").processContent({"content":_loc1_.join(this._mainblock.getChunk("separator").processContent(null))});
         }
         else
         {
            this._content = this._mainblock.getChunk("main").processContent({"content":_loc1_.join("")});
         }
      }
      
      private function onChunkReady(param1:Event) : void {
         this._loadedblock++;
         this.processCallback();
      }
   }
}
