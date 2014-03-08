package com.ankamagames.berilia.types.template
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   import com.ankamagames.jerakine.eval.Evaluator;
   import com.ankamagames.berilia.enums.XmlTagsEnum;
   import com.ankamagames.berilia.enums.XmlAttributesEnum;
   
   public class XmlTemplate extends Object
   {
      
      public function XmlTemplate(param1:String=null, param2:String=null) {
         this._aVariablesStack = new Array();
         super();
         this._filename = param2;
         if(param1 != null)
         {
            this.xml = param1;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlTemplate));
      
      private var _aTemplateParams:Array;
      
      private var _sXml:String;
      
      private var _xDoc:XMLDocument;
      
      private var _aVariablesStack:Array;
      
      private var _filename:String;
      
      public function get xml() : String {
         return this._sXml;
      }
      
      public function set xml(param1:String) : void {
         this._sXml = param1;
         this.parseTemplate();
      }
      
      public function get filename() : String {
         return this._filename;
      }
      
      public function set filename(param1:String) : void {
         this._filename = param1;
      }
      
      public function get templateParams() : Array {
         return this._aTemplateParams;
      }
      
      public function get variablesStack() : Array {
         return this._aVariablesStack;
      }
      
      public function makeTemplate(param1:Array) : XMLNode {
         var _loc4_:String = null;
         var _loc6_:Array = null;
         var _loc7_:TemplateVar = null;
         var _loc8_:uint = 0;
         var _loc2_:Evaluator = new Evaluator();
         var _loc3_:String = this._xDoc.toString();
         var _loc5_:Array = [];
         for (_loc4_ in this._aTemplateParams)
         {
            _loc5_[_loc4_] = this._aTemplateParams[_loc4_];
         }
         for (_loc4_ in param1)
         {
            if(!this._aTemplateParams[_loc4_])
            {
               _log.error("Template " + this._filename + ", param " + _loc4_ + " is not defined");
               delete param1[[_loc4_]];
            }
            else
            {
               _loc5_[_loc4_] = param1[_loc4_];
            }
         }
         _loc3_ = this.replaceParam(_loc3_,_loc5_,"#");
         _loc6_ = new Array();
         _loc8_ = 0;
         while(_loc8_ < this._aVariablesStack.length)
         {
            _loc7_ = this._aVariablesStack[_loc8_].clone();
            _loc7_.value = _loc2_.eval(this.replaceParam(this.replaceParam(_loc7_.value,_loc5_,"#"),_loc6_,"$"));
            _loc6_[_loc7_.name] = _loc7_;
            _loc8_++;
         }
         _loc3_ = this.replaceParam(_loc3_,_loc6_,"$");
         var _loc9_:XMLDocument = new XMLDocument();
         _loc9_.parseXML(_loc3_);
         return _loc9_;
      }
      
      private function parseTemplate() : void {
         this._xDoc = new XMLDocument();
         this._aTemplateParams = new Array();
         this._xDoc.ignoreWhite = true;
         this._xDoc.parseXML(this._sXml);
         if(this._xDoc.firstChild.nodeName + ".xml" != this._filename)
         {
            _log.error("Wrong root node name in " + this._filename + ", found " + this._xDoc.firstChild.nodeName + ", waiting for " + this._filename.replace(".xml",""));
            return;
         }
         this.matchDynamicsParts(this._xDoc.firstChild);
      }
      
      private function matchDynamicsParts(param1:XMLNode) : void {
         var _loc2_:XMLNode = null;
         var _loc3_:TemplateVar = null;
         var _loc4_:TemplateParam = null;
         var _loc5_:uint = 0;
         for(;_loc5_ < param1.childNodes.length;_loc5_++)
         {
            _loc2_ = param1.childNodes[_loc5_];
            if(_loc2_.nodeName == XmlTagsEnum.TAG_VAR)
            {
               if(_loc2_.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
               {
                  _loc3_ = new TemplateVar(_loc2_.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]);
                  _loc3_.value = _loc2_.firstChild.toString().replace(new RegExp("&apos;","g"),"\'");
                  this._aVariablesStack.push(_loc3_);
                  _loc2_.removeNode();
                  _loc5_--;
                  continue;
               }
               _log.warn(_loc2_.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
            }
            if(_loc2_.nodeName == XmlTagsEnum.TAG_PARAM)
            {
               if(_loc2_.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
               {
                  _loc4_ = new TemplateParam(_loc2_.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]);
                  this._aTemplateParams[_loc4_.name] = _loc4_;
                  if(_loc2_.hasChildNodes())
                  {
                     _loc4_.defaultValue = _loc2_.firstChild.toString();
                  }
                  else
                  {
                     _loc4_.defaultValue = "";
                  }
                  _loc2_.removeNode();
                  _loc5_--;
               }
               else
               {
                  _log.warn(_loc2_.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
               }
            }
         }
      }
      
      private function replaceParam(param1:String, param2:Array, param3:String, param4:uint=1) : String {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         if(!param1)
         {
            return param1;
         }
         var _loc6_:Array = new Array();
         for (_loc7_ in param2)
         {
            _loc6_.push(_loc7_);
         }
         _loc6_.sort(Array.DESCENDING);
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc8_];
            if(param2[_loc7_] != null)
            {
               _loc5_ = param2[_loc7_].value;
               if(!_loc5_ && param2[_loc7_] is TemplateParam)
               {
                  _loc5_ = param2[_loc7_].defaultValue;
               }
               if(_loc5_ == null)
               {
                  _log.warn("No value for " + param3 + _loc7_);
               }
               else
               {
                  param1 = param1.split(param3 + _loc7_).join(_loc5_);
               }
            }
            _loc8_++;
         }
         return param1;
      }
   }
}
