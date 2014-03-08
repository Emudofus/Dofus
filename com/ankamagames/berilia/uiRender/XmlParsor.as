package com.ankamagames.berilia.uiRender
{
   import flash.events.EventDispatcher;
   import com.ankamagames.berilia.utils.ComponentList;
   import com.ankamagames.berilia.utils.GridItemList;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.xml.XMLDocument;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.event.ParsorEvent;
   import com.ankamagames.berilia.types.event.PreProcessEndEvent;
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   import flash.xml.XMLNode;
   import com.ankamagames.berilia.enums.XmlAttributesEnum;
   import com.ankamagames.berilia.enums.XmlTagsEnum;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.berilia.types.uiDefinition.BasicElement;
   import com.ankamagames.berilia.types.uiDefinition.ContainerElement;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.uiDefinition.ScrollContainerElement;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import com.ankamagames.berilia.types.uiDefinition.GridElement;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.InputComboBox;
   import com.ankamagames.berilia.components.Tree;
   import com.ankamagames.berilia.types.uiDefinition.StateContainerElement;
   import com.ankamagames.berilia.types.graphic.StateContainer;
   import com.ankamagames.berilia.types.uiDefinition.ButtonElement;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.uiDefinition.ComponentElement;
   import flash.utils.getDefinitionByName;
   import flash.system.ApplicationDomain;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.GraphicSize;
   import com.ankamagames.berilia.types.graphic.GraphicLocation;
   import com.ankamagames.berilia.enums.LocationTypeEnum;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.jerakine.utils.misc.Levenshtein;
   import flash.events.Event;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.berilia.types.event.ParsingErrorEvent;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   
   public class XmlParsor extends EventDispatcher
   {
      
      public function XmlParsor() {
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._describeType = DescribeTypeCache.typeDescription;
         super();
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onXmlLoadComplete);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onXmlLoadError);
      }
      
      private static var _classDescCache:Object = new Object();
      
      protected const _componentList:ComponentList = null;
      
      protected const _GridItemList:GridItemList = null;
      
      protected const _log:Logger = Log.getLogger(getQualifiedClassName(XmlParsor));
      
      private var _xmlDoc:XMLDocument;
      
      private var _sUrl:String;
      
      protected var _aName:Array;
      
      private var _loader:IResourceLoader;
      
      private var _describeType:Function;
      
      public var rootPath:String;
      
      public function get url() : String {
         return this._sUrl;
      }
      
      public function get xmlDocString() : String {
         return this._xmlDoc?this._xmlDoc.toString():null;
      }
      
      public function processFile(param1:String) : void {
         this._sUrl = param1;
         this._loader.load(new Uri(this._sUrl));
      }
      
      public function processXml(param1:String) : void {
         var errorLog:String = null;
         var i:uint = 0;
         var regOpenTagAdv:RegExp = null;
         var regOpenTag:RegExp = null;
         var tmp:Array = null;
         var openTag:Array = null;
         var tag:String = null;
         var regCloseTag:RegExp = null;
         var closeTag:Array = null;
         var sXml:String = param1;
         this._xmlDoc = new XMLDocument();
         this._xmlDoc.ignoreWhite = true;
         try
         {
            this._xmlDoc.parseXML(sXml.toString());
         }
         catch(e:Error)
         {
            if(sXml)
            {
               regOpenTagAdv = new RegExp("<\\w+[^>]*","g");
               regOpenTag = new RegExp("<\\w+","g");
               tmp = sXml.match(regOpenTagAdv);
               openTag = new Array();
               i = 0;
               while(i < tmp.length)
               {
                  if(tmp[i].substr(tmp[i].length-1) != "/")
                  {
                     tag = tmp[i].match(regOpenTag)[0];
                     if(!openTag[tag])
                     {
                        openTag[tag] = 0;
                     }
                     openTag[tag]++;
                  }
                  i++;
               }
               regCloseTag = new RegExp("<\\/\\w+","g");
               tmp = sXml.match(regCloseTag);
               closeTag = new Array();
               i = 0;
               while(i < tmp.length)
               {
                  tag = "<" + tmp[i].substr(2);
                  if(!closeTag[tag])
                  {
                     closeTag[tag] = 0;
                  }
                  closeTag[tag]++;
                  i++;
               }
            }
            errorLog = "";
            for (tag in openTag)
            {
               if(!closeTag[tag] || !(closeTag[tag] == openTag[tag]))
               {
                  errorLog = errorLog + ("\n - " + tag + " have no closing tag");
               }
            }
            for (tag in closeTag)
            {
               if(!openTag[tag] || !(openTag[tag] == closeTag[tag]))
               {
                  errorLog = errorLog + ("\n - </" + tag.substr(1) + "> is lonely closing tag");
               }
            }
            _log.error("Error when parsing " + _sUrl + ", misformatted xml" + (errorLog.length?" : " + errorLog:""));
            dispatchEvent(new ParsorEvent(null,true));
         }
         this._aName = new Array();
         this.preProccessXml();
      }
      
      private function preProccessXml() : void {
         var _loc1_:XmlPreProcessor = new XmlPreProcessor(this._xmlDoc);
         _loc1_.addEventListener(PreProcessEndEvent.PRE_PROCESS_END,this.onPreProcessCompleted);
         _loc1_.processTemplate();
      }
      
      private function mainProcess() : void {
         if((this._xmlDoc) && (this._xmlDoc.firstChild))
         {
            dispatchEvent(new ParsorEvent(this.parseMainNode(this._xmlDoc.firstChild),false));
         }
         else
         {
            dispatchEvent(new ParsorEvent(null,true));
         }
      }
      
      protected function parseMainNode(param1:XMLNode) : UiDefinition {
         var _loc12_:XMLNode = null;
         var _loc14_:* = 0;
         var _loc2_:UiDefinition = new UiDefinition();
         var _loc3_:Array = param1.childNodes;
         if(!_loc3_.length)
         {
            return null;
         }
         var _loc4_:Object = param1.attributes;
         var _loc5_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_DEBUG];
         var _loc6_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_USECACHE];
         var _loc7_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_USEPROPERTIESCACHE];
         var _loc8_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_MODAL];
         var _loc9_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_SCALABLE];
         var _loc10_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_FOCUS];
         var _loc11_:String = _loc4_[XmlAttributesEnum.ATTRIBUTE_TRANSMITFOCUS];
         if(_loc5_)
         {
            _loc2_.debug = _loc5_ == "true";
         }
         if(_loc6_)
         {
            _loc2_.useCache = _loc6_ == "true";
         }
         if(_loc7_)
         {
            _loc2_.usePropertiesCache = _loc7_ == "true";
         }
         if(_loc8_)
         {
            _loc2_.modal = _loc8_ == "true";
         }
         if(_loc9_)
         {
            _loc2_.scalable = _loc9_ == "true";
         }
         if(_loc10_)
         {
            _loc2_.giveFocus = _loc10_ == "true";
         }
         if(_loc11_)
         {
            _loc2_.transmitFocus = _loc11_ == "true";
         }
         var _loc13_:int = _loc3_.length;
         _loc14_ = 0;
         while(_loc14_ < _loc13_)
         {
            _loc12_ = _loc3_[_loc14_];
            switch(_loc12_.nodeName)
            {
               case XmlTagsEnum.TAG_CONSTANTS:
                  this.parseConstants(_loc12_,_loc2_.constants);
                  break;
               case XmlTagsEnum.TAG_CONTAINER:
               case XmlTagsEnum.TAG_SCROLLCONTAINER:
               case XmlTagsEnum.TAG_STATECONTAINER:
               case XmlTagsEnum.TAG_BUTTON:
                  _loc2_.graphicTree.push(this.parseGraphicElement(_loc12_));
                  break;
               case XmlTagsEnum.TAG_SHORTCUTS:
                  _loc2_.shortcutsEvents = this.parseShortcutsEvent(_loc12_);
                  break;
               default:
                  this._log.warn("[" + this._sUrl + "] " + _loc12_.nodeName + " is not allow or unknow. " + this.suggest(_loc12_.nodeName,[XmlTagsEnum.TAG_CONTAINER,XmlTagsEnum.TAG_STATECONTAINER,XmlTagsEnum.TAG_BUTTON,XmlTagsEnum.TAG_SHORTCUTS]));
            }
            _loc14_ = _loc14_ + 1;
         }
         this.cleanLocalConstants(_loc2_.constants);
         return _loc2_;
      }
      
      private function cleanLocalConstants(param1:Array) : void {
         var _loc2_:String = null;
         for (_loc2_ in param1)
         {
            LangManager.getInstance().deleteEntry("local." + _loc2_);
         }
      }
      
      protected function parseConstants(param1:XMLNode, param2:Array) : void {
         var _loc3_:XMLNode = null;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc4_:Array = param1.childNodes;
         var _loc5_:int = _loc4_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc4_[_loc6_];
            _loc8_ = _loc3_.nodeName;
            if(_loc8_ != XmlTagsEnum.TAG_CONSTANT)
            {
               this._log.error(_loc8_ + " found, wrong node name, waiting for " + XmlTagsEnum.TAG_CONSTANT + " in " + this._sUrl);
            }
            else
            {
               _loc9_ = _loc3_.attributes["name"];
               if(!_loc9_)
               {
                  this._log.error("Constant name\'s not found in " + this._sUrl);
               }
               else
               {
                  _loc7_ = LangManager.getInstance().replaceKey(_loc3_.attributes["value"]);
                  _loc10_ = _loc3_.attributes["type"];
                  if(_loc10_)
                  {
                     _loc10_ = _loc10_.toUpperCase();
                     if(_loc10_ == "STRING")
                     {
                        param2[_loc9_] = _loc7_;
                     }
                     else
                     {
                        if(_loc10_ == "NUMBER")
                        {
                           param2[_loc9_] = Number(_loc7_);
                        }
                        else
                        {
                           if(_loc10_ == "UINT" || _loc10_ == "INT")
                           {
                              param2[_loc9_] = int(_loc7_);
                           }
                           else
                           {
                              if(_loc10_ == "BOOLEAN")
                              {
                                 param2[_loc9_] = _loc7_ == "true";
                              }
                              else
                              {
                                 if(_loc10_ == "ARRAY")
                                 {
                                    param2[_loc9_] = _loc7_.split(",");
                                 }
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     param2[_loc9_] = _loc7_;
                  }
                  LangManager.getInstance().setEntry("local." + _loc9_,_loc7_);
               }
            }
            _loc6_ = _loc6_ + 1;
         }
      }
      
      protected function parseGraphicElement(param1:XMLNode, param2:XMLNode=null, param3:BasicElement=null) : BasicElement {
         var _loc4_:XMLNode = null;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         var _loc9_:Class = null;
         var _loc10_:* = undefined;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Class = null;
         var _loc15_:String = null;
         var _loc5_:Array = param1.childNodes;
         var _loc6_:int = _loc5_.length;
         if(!param2)
         {
            param2 = param1;
         }
         if(!param3)
         {
            switch(param2.nodeName)
            {
               case XmlTagsEnum.TAG_CONTAINER:
                  param3 = new ContainerElement();
                  param3.className = getQualifiedClassName(GraphicContainer);
                  break;
               case XmlTagsEnum.TAG_SCROLLCONTAINER:
                  param3 = new ScrollContainerElement();
                  param3.className = getQualifiedClassName(ScrollContainer);
                  break;
               case XmlTagsEnum.TAG_GRID:
                  param3 = new GridElement();
                  param3.className = getQualifiedClassName(Grid);
                  break;
               case XmlTagsEnum.TAG_COMBOBOX:
                  param3 = new GridElement();
                  param3.className = getQualifiedClassName(ComboBox);
                  break;
               case XmlTagsEnum.TAG_INPUTCOMBOBOX:
                  param3 = new GridElement();
                  param3.className = getQualifiedClassName(InputComboBox);
                  break;
               case XmlTagsEnum.TAG_TREE:
                  param3 = new GridElement();
                  param3.className = getQualifiedClassName(Tree);
                  break;
               case XmlTagsEnum.TAG_STATECONTAINER:
                  param3 = new StateContainerElement();
                  param3.className = getQualifiedClassName(StateContainer);
                  break;
               case XmlTagsEnum.TAG_BUTTON:
                  param3 = new ButtonElement();
                  param3.className = getQualifiedClassName(ButtonContainer);
                  break;
               default:
                  param3 = new ComponentElement();
                  ComponentElement(param3).className = "com.ankamagames.berilia.components::" + param2.nodeName;
            }
         }
         for (_loc18_ in param2.attributes)
         {
            switch(_loc8_)
            {
               case XmlAttributesEnum.ATTRIBUTE_NAME:
                  param3.setName(param2.attributes[_loc8_]);
                  this._aName[param2.attributes[_loc8_]] = param3;
                  continue;
               case XmlAttributesEnum.ATTRIBUTE_VISIBLE:
                  param3.properties["visible"] = Boolean(param2.attributes[_loc8_]);
                  continue;
               case XmlAttributesEnum.ATTRIBUTE_STRATA:
                  param3.strata = this.getStrataNum(param2.attributes[_loc8_]);
                  continue;
               default:
                  this._log.warn("[" + this._sUrl + "] Unknow attribute \'" + _loc8_ + "\' in " + XmlTagsEnum.TAG_CONTAINER + " tag");
                  continue;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = _loc5_[_loc7_];
            switch(_loc4_.nodeName)
            {
               case XmlTagsEnum.TAG_ANCHORS:
                  param3.anchors = this.parseAnchors(_loc4_);
                  break;
               case XmlTagsEnum.TAG_SIZE:
                  param3.size = this.parseSize(_loc4_,true).toSizeElement();
                  break;
               case XmlTagsEnum.TAG_EVENTS:
                  param3.event = this.parseEvent(_loc4_);
                  break;
               case XmlTagsEnum.TAG_MINIMALSIZE:
                  param3.minSize = this.parseSize(_loc4_,false).toSizeElement();
                  break;
               case XmlTagsEnum.TAG_MAXIMALSIZE:
                  param3.maxSize = this.parseSize(_loc4_,false).toSizeElement();
                  break;
               case XmlTagsEnum.TAG_SCROLLCONTAINER:
               case XmlTagsEnum.TAG_CONTAINER:
               case XmlTagsEnum.TAG_GRID:
               case XmlTagsEnum.TAG_COMBOBOX:
               case XmlTagsEnum.TAG_INPUTCOMBOBOX:
               case XmlTagsEnum.TAG_TREE:
                  switch(param2.nodeName)
                  {
                     case XmlTagsEnum.TAG_CONTAINER:
                     case XmlTagsEnum.TAG_BUTTON:
                     case XmlTagsEnum.TAG_STATECONTAINER:
                     case XmlTagsEnum.TAG_SCROLLCONTAINER:
                     case XmlTagsEnum.TAG_COMBOBOX:
                     case XmlTagsEnum.TAG_INPUTCOMBOBOX:
                     case XmlTagsEnum.TAG_TREE:
                     case XmlTagsEnum.TAG_GRID:
                        ContainerElement(param3).childs.push(this.parseGraphicElement(_loc4_));
                        break;
                     default:
                        this._log.warn("[" + this._sUrl + "] " + param2.nodeName + " cannot contains " + _loc4_.nodeName);
                  }
                  break;
               case XmlTagsEnum.TAG_STATECONTAINER:
               case XmlTagsEnum.TAG_BUTTON:
                  switch(param2.nodeName)
                  {
                     case XmlTagsEnum.TAG_CONTAINER:
                     case XmlTagsEnum.TAG_STATECONTAINER:
                     case XmlTagsEnum.TAG_SCROLLCONTAINER:
                     case XmlTagsEnum.TAG_GRID:
                     case XmlTagsEnum.TAG_COMBOBOX:
                     case XmlTagsEnum.TAG_INPUTCOMBOBOX:
                     case XmlTagsEnum.TAG_TREE:
                        ContainerElement(param3).childs.push(this.parseStateContainer(_loc4_,_loc4_.nodeName));
                        break;
                     default:
                        this._log.warn("[" + this._sUrl + "] " + param2.nodeName + " cannot contains Button");
                  }
                  break;
               default:
                  switch(param2.nodeName)
                  {
                     case XmlTagsEnum.TAG_CONTAINER:
                        _loc9_ = GraphicContainer;
                        break;
                     case XmlTagsEnum.TAG_BUTTON:
                        _loc9_ = ButtonContainer;
                        break;
                     case XmlTagsEnum.TAG_STATECONTAINER:
                        _loc9_ = StateContainer;
                        break;
                     case XmlTagsEnum.TAG_SCROLLCONTAINER:
                        _loc9_ = ScrollContainer;
                        break;
                     case XmlTagsEnum.TAG_GRID:
                        _loc9_ = Grid;
                        break;
                     case XmlTagsEnum.TAG_COMBOBOX:
                        _loc9_ = ComboBox;
                        break;
                     case XmlTagsEnum.TAG_INPUTCOMBOBOX:
                        _loc9_ = InputComboBox;
                        break;
                     case XmlTagsEnum.TAG_TREE:
                        _loc9_ = Tree;
                        break;
                  }
                  _loc11_ = this.getClassDesc(_loc9_);
                  if(_loc11_[_loc4_.nodeName])
                  {
                     if(_loc4_.firstChild)
                     {
                        _loc12_ = _loc4_.toString();
                        _loc13_ = _loc12_.substr(_loc4_.nodeName.length + 2,_loc12_.length - _loc4_.nodeName.length * 2 - 5);
                        _loc10_ = LangManager.getInstance().replaceKey(_loc13_);
                        switch(_loc11_[_loc4_.nodeName])
                        {
                           case "Boolean":
                              _loc10_ = !(_loc10_ == "false");
                              break;
                           default:
                              if(_loc10_.charAt(0) == "[" && _loc10_.charAt(_loc10_.length-1) == "]")
                              {
                                 break;
                              }
                              _loc14_ = getDefinitionByName(_loc11_[_loc4_.nodeName]) as Class;
                              _loc10_ = new _loc14_(_loc10_);
                              break;
                        }
                        ContainerElement(param3).properties[_loc4_.nodeName] = _loc10_;
                     }
                  }
                  else
                  {
                     switch(param2.nodeName)
                     {
                        case XmlTagsEnum.TAG_CONTAINER:
                        case XmlTagsEnum.TAG_BUTTON:
                        case XmlTagsEnum.TAG_STATECONTAINER:
                        case XmlTagsEnum.TAG_SCROLLCONTAINER:
                        case XmlTagsEnum.TAG_GRID:
                        case XmlTagsEnum.TAG_COMBOBOX:
                        case XmlTagsEnum.TAG_INPUTCOMBOBOX:
                        case XmlTagsEnum.TAG_TREE:
                           if(ApplicationDomain.currentDomain.hasDefinition("com.ankamagames.berilia.components." + _loc4_.nodeName))
                           {
                              ContainerElement(param3).childs.push(this.parseGraphicElement(_loc4_));
                           }
                           else
                           {
                              this._log.warn("[" + this._sUrl + "] " + _loc4_.nodeName + " is unknown component / property on " + param2.nodeName);
                           }
                           break;
                        default:
                           if(_loc4_.firstChild != null)
                           {
                              _loc15_ = _loc4_.toString();
                              param3.properties[_loc4_.nodeName] = _loc15_.substr(_loc4_.nodeName.length + 2,_loc15_.length - _loc4_.nodeName.length * 2 - 5);
                           }
                     }
                  }
            }
            _loc7_ = _loc7_ + 1;
         }
         if(param3 is ComponentElement)
         {
            this.cleanComponentProperty(ComponentElement(param3));
         }
         return param3;
      }
      
      protected function parseStateContainer(param1:XMLNode, param2:String) : * {
         var _loc3_:XMLNode = null;
         var _loc6_:* = 0;
         var _loc7_:StateContainerElement = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc4_:Array = param1.childNodes;
         var _loc5_:int = _loc4_.length;
         if(param2 == XmlTagsEnum.TAG_BUTTON)
         {
            _loc7_ = new ButtonElement();
         }
         if(param2 == XmlTagsEnum.TAG_STATECONTAINER)
         {
            _loc7_ = new StateContainerElement();
         }
         _loc7_.className = getQualifiedClassName(ButtonContainer);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc4_[_loc6_];
            switch(_loc3_.nodeName)
            {
               case XmlTagsEnum.TAG_COMMON:
                  this.parseGraphicElement(_loc3_,param1,_loc7_);
                  break;
               case XmlTagsEnum.TAG_STATE:
                  _loc9_ = _loc3_.attributes[XmlAttributesEnum.ATTRIBUTE_TYPE];
                  if(_loc9_)
                  {
                     if(param2 == XmlTagsEnum.TAG_STATECONTAINER)
                     {
                        _loc8_ = _loc9_;
                     }
                     else
                     {
                        _loc8_ = 9999;
                        switch(_loc9_)
                        {
                           case StatesEnum.STATE_CLICKED_STRING:
                              _loc8_ = StatesEnum.STATE_CLICKED;
                              break;
                           case StatesEnum.STATE_OVER_STRING:
                              _loc8_ = StatesEnum.STATE_OVER;
                              break;
                           case StatesEnum.STATE_DISABLED_STRING:
                              _loc8_ = StatesEnum.STATE_DISABLED;
                              break;
                           case StatesEnum.STATE_SELECTED_STRING:
                              _loc8_ = StatesEnum.STATE_SELECTED;
                              break;
                           case StatesEnum.STATE_SELECTED_OVER_STRING:
                              _loc8_ = StatesEnum.STATE_SELECTED_OVER;
                              break;
                           case StatesEnum.STATE_SELECTED_CLICKED_STRING:
                              _loc8_ = StatesEnum.STATE_SELECTED_CLICKED;
                              break;
                           default:
                              _loc10_ = new Array(StatesEnum.STATE_CLICKED_STRING,StatesEnum.STATE_OVER_STRING,StatesEnum.STATE_SELECTED_STRING,StatesEnum.STATE_SELECTED_OVER_STRING,StatesEnum.STATE_SELECTED_CLICKED_STRING,StatesEnum.STATE_DISABLED_STRING);
                              this._log.warn(_loc9_ + " is not a valid state" + this.suggest(_loc9_,_loc10_));
                        }
                     }
                     if(_loc8_ != 9999)
                     {
                        if(!_loc7_.stateChangingProperties[_loc8_])
                        {
                           _loc7_.stateChangingProperties[_loc8_] = new Array();
                        }
                        this.parseSetProperties(_loc3_,_loc7_.stateChangingProperties[_loc8_]);
                     }
                  }
                  else
                  {
                     this._log.warn(XmlTagsEnum.TAG_STATE + " must have attribute [" + XmlAttributesEnum.ATTRIBUTE_TYPE + "]");
                  }
                  break;
               default:
                  this._log.warn(param2 + " does not allow " + _loc3_.nodeName + this.suggest(_loc3_.nodeName,[XmlTagsEnum.TAG_COMMON,XmlTagsEnum.TAG_STATE]));
            }
            _loc6_ = _loc6_ + 1;
         }
         return _loc7_;
      }
      
      protected function parseSetProperties(param1:XMLNode, param2:Object) : void {
         var _loc3_:XMLNode = null;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:XMLNode = null;
         var _loc10_:Array = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc4_:Array = param1.childNodes;
         var _loc5_:int = _loc4_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc4_[_loc6_];
            if(_loc3_.nodeName == XmlTagsEnum.TAG_SETPROPERTY)
            {
               _loc7_ = _loc3_.attributes[XmlAttributesEnum.ATTRIBUTE_TARGET];
               if(_loc7_)
               {
                  if(this._aName[_loc7_])
                  {
                     if(!param2[_loc7_])
                     {
                        param2[_loc7_] = new Array();
                     }
                     _loc8_ = param2[_loc7_];
                     _loc10_ = _loc3_.childNodes;
                     _loc11_ = _loc10_.length;
                     _loc12_ = 0;
                     while(_loc12_ < _loc11_)
                     {
                        _loc9_ = _loc10_[_loc12_];
                        _loc8_[_loc9_.nodeName] = LangManager.getInstance().replaceKey(_loc9_.firstChild.toString());
                        _loc12_ = _loc12_ + 1;
                     }
                     this.cleanComponentProperty(this._aName[_loc7_],_loc8_);
                  }
                  else
                  {
                     this._log.warn("Unknow reference to \"" + _loc7_ + "\" in " + XmlTagsEnum.TAG_SETPROPERTY);
                  }
               }
               else
               {
                  this._log.warn("Cannot set button properties, not yet implemented");
               }
            }
            else
            {
               this._log.warn("Only " + XmlTagsEnum.TAG_SETPROPERTY + " tags are authorized in " + XmlTagsEnum.TAG_STATE + " tags (found " + _loc3_.nodeName + ")");
            }
            _loc6_ = _loc6_ + 1;
         }
      }
      
      private function cleanComponentProperty(param1:BasicElement, param2:Array=null) : Boolean {
         var _loc6_:* = undefined;
         var _loc7_:Class = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         if(!param2)
         {
            param2 = param1.properties;
         }
         var _loc3_:Class = getDefinitionByName(param1.className) as Class;
         var _loc4_:Object = this.getClassDesc(_loc3_);
         var _loc5_:Array = new Array();
         for (_loc8_ in param2)
         {
            if(_loc4_[_loc8_])
            {
               _loc6_ = LangManager.getInstance().replaceKey(param2[_loc8_]);
               switch(_loc4_[_loc8_])
               {
                  case "Boolean":
                     _loc6_ = !(_loc6_ == "false");
                     break;
                  case getQualifiedClassName(Uri):
                     _loc7_ = getDefinitionByName(_loc4_[_loc8_]) as Class;
                     _loc6_ = new _loc7_(_loc6_);
                     break;
                  case "*":
                     break;
                  default:
                     if(_loc6_.charAt(0) == "[" && _loc6_.charAt(_loc6_.length-1) == "]")
                     {
                        break;
                     }
                     _loc7_ = getDefinitionByName(_loc4_[_loc8_]) as Class;
                     _loc6_ = new _loc7_(_loc6_);
                     break;
               }
               _loc5_[_loc8_] = _loc6_;
            }
            else
            {
               _loc10_ = new Array();
               for (_loc11_ in _loc4_)
               {
                  _loc10_.push(_loc11_);
               }
               this._log.warn("[" + this._sUrl + "]" + _loc8_ + " is unknow for " + param1.className + " component" + this.suggest(_loc8_,_loc10_));
            }
         }
         for (_loc9_ in _loc5_)
         {
            param2[_loc9_] = _loc5_[_loc9_];
         }
         return true;
      }
      
      protected function getClassDesc(param1:Object) : Object {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc2_:String = getQualifiedClassName(param1);
         if(_classDescCache[_loc2_])
         {
            return _classDescCache[_loc2_];
         }
         var _loc3_:XML = this._describeType(param1);
         var _loc4_:Object = new Object();
         for each (_loc5_ in _loc3_..accessor)
         {
            _loc4_[_loc5_.@name.toString()] = _loc5_.@type.toString();
         }
         for each (_loc6_ in _loc3_..variable)
         {
            _loc4_[_loc6_.@name.toString()] = _loc6_.@type.toString();
         }
         return _loc4_;
      }
      
      protected function parseSize(param1:XMLNode, param2:Boolean) : GraphicSize {
         var _loc3_:XMLNode = null;
         var _loc6_:* = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param1.attributes.length)
         {
            this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " cannot have attribut");
         }
         var _loc4_:Array = param1.childNodes;
         var _loc5_:int = _loc4_.length;
         var _loc7_:GraphicSize = new GraphicSize();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc4_[_loc6_];
            if(_loc3_.nodeName == XmlTagsEnum.TAG_RELDIMENSION)
            {
               if(!param2)
               {
                  this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " does not allow relative size");
               }
               else
               {
                  _loc8_ = _loc3_.attributes["x"];
                  if(_loc8_)
                  {
                     _loc7_.setX(Number(LangManager.getInstance().replaceKey(_loc8_)),GraphicSize.SIZE_PRC);
                  }
                  _loc9_ = _loc3_.attributes["y"];
                  if(_loc9_)
                  {
                     _loc7_.setY(Number(LangManager.getInstance().replaceKey(_loc9_)),GraphicSize.SIZE_PRC);
                  }
               }
            }
            if(_loc3_.nodeName == XmlTagsEnum.TAG_ABSDIMENSION)
            {
               _loc8_ = _loc3_.attributes["x"];
               if(_loc8_)
               {
                  _loc7_.setX(int(LangManager.getInstance().replaceKey(_loc8_)),GraphicSize.SIZE_PIXEL);
               }
               _loc9_ = _loc3_.attributes["y"];
               if(_loc9_)
               {
                  _loc7_.setY(int(LangManager.getInstance().replaceKey(_loc9_)),GraphicSize.SIZE_PIXEL);
               }
            }
            _loc6_ = _loc6_ + 1;
         }
         return _loc7_;
      }
      
      protected function parseAnchors(param1:XMLNode) : Array {
         var _loc2_:XMLNode = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:XMLNode = null;
         var _loc9_:GraphicLocation = null;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:* = 0;
         if(param1.attributes.length)
         {
            this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " cannot have attribut");
         }
         var _loc3_:Array = param1.childNodes;
         var _loc4_:int = _loc3_.length;
         var _loc8_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc9_ = new GraphicLocation();
            _loc2_ = _loc3_[_loc5_];
            if(_loc2_.nodeName == XmlTagsEnum.TAG_ANCHOR)
            {
               for (_loc15_ in _loc2_.attributes)
               {
                  switch(_loc10_)
                  {
                     case XmlAttributesEnum.ATTRIBUTE_POINT:
                        if(_loc8_.length != 0)
                        {
                           this._log.error("[" + this._sUrl + "] When using double anchors, you cannot define attribute POINT");
                        }
                        else
                        {
                           _loc9_.setPoint(_loc2_.attributes[_loc10_]);
                        }
                        continue;
                     case XmlAttributesEnum.ATTRIBUTE_RELATIVEPOINT:
                        _loc9_.setRelativePoint(_loc2_.attributes[_loc10_]);
                        continue;
                     case XmlAttributesEnum.ATTRIBUTE_RELATIVETO:
                        _loc9_.setRelativeTo(_loc2_.attributes[_loc10_]);
                        continue;
                     default:
                        this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " cannot have " + _loc10_ + " attribut");
                        continue;
                  }
               }
               _loc11_ = _loc2_.childNodes;
               _loc12_ = _loc11_.length;
               _loc6_ = 0;
               while(_loc6_ < _loc12_)
               {
                  _loc7_ = _loc11_[_loc6_];
                  switch(_loc7_.nodeName)
                  {
                     case XmlTagsEnum.TAG_OFFSET:
                        _loc7_ = _loc7_.firstChild;
                        break;
                     case XmlTagsEnum.TAG_RELDIMENSION:
                        if(_loc7_.attributes["x"] != null)
                        {
                           _loc9_.offsetXType = LocationTypeEnum.LOCATION_TYPE_RELATIVE;
                           _loc9_.setOffsetX(_loc7_.attributes["x"]);
                        }
                        if(_loc7_.attributes["y"] != null)
                        {
                           _loc9_.offsetYType = LocationTypeEnum.LOCATION_TYPE_RELATIVE;
                           _loc9_.setOffsetY(_loc7_.attributes["y"]);
                        }
                        break;
                     case XmlTagsEnum.TAG_ABSDIMENSION:
                        if(_loc7_.attributes["x"] != null)
                        {
                           _loc9_.offsetXType = LocationTypeEnum.LOCATION_TYPE_ABSOLUTE;
                           _loc9_.setOffsetX(_loc7_.attributes["x"]);
                        }
                        if(_loc7_.attributes["y"] != null)
                        {
                           _loc9_.offsetYType = LocationTypeEnum.LOCATION_TYPE_ABSOLUTE;
                           _loc9_.setOffsetY(_loc7_.attributes["y"]);
                        }
                        break;
                  }
                  _loc6_ = _loc6_ + 1;
               }
               _loc8_.push(_loc9_.toLocationElement());
            }
            else
            {
               this._log.warn("[" + this._sUrl + "] " + param1.nodeName + " does not allow " + _loc2_.nodeName + " tag");
            }
            _loc5_ = _loc5_ + 1;
         }
         return _loc8_.length?_loc8_:null;
      }
      
      protected function parseShortcutsEvent(param1:XMLNode) : Array {
         var _loc2_:XMLNode = null;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc3_:Array = param1.childNodes;
         var _loc4_:int = _loc3_.length;
         var _loc7_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc5_];
            _loc6_ = _loc2_.nodeName;
            if(!BindsManager.getInstance().isRegisteredName(_loc6_))
            {
               this._log.info("[" + this._sUrl + "] Shortcut " + _loc6_ + " is not defined.");
            }
            _loc7_.push(_loc6_);
            _loc5_ = _loc5_ + 1;
         }
         return _loc7_;
      }
      
      private function parseEvent(param1:XMLNode) : Array {
         var _loc2_:XMLNode = null;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc8_:Array = null;
         var _loc3_:Array = param1.childNodes;
         var _loc4_:int = _loc3_.length;
         var _loc7_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc5_];
            _loc6_ = "";
            switch(_loc2_.nodeName)
            {
               case EventEnums.EVENT_ONPRESS:
                  _loc6_ = EventEnums.EVENT_ONPRESS_MSG;
                  break;
               case EventEnums.EVENT_ONRELEASE:
                  _loc6_ = EventEnums.EVENT_ONRELEASE_MSG;
                  break;
               case EventEnums.EVENT_ONROLLOUT:
                  _loc6_ = EventEnums.EVENT_ONROLLOUT_MSG;
                  break;
               case EventEnums.EVENT_ONROLLOVER:
                  _loc6_ = EventEnums.EVENT_ONROLLOVER_MSG;
                  break;
               case EventEnums.EVENT_ONRELEASEOUTSIDE:
                  _loc6_ = EventEnums.EVENT_ONRELEASEOUTSIDE_MSG;
                  break;
               case EventEnums.EVENT_ONRIGHTCLICK:
                  _loc6_ = EventEnums.EVENT_ONRIGHTCLICK_MSG;
                  break;
               case EventEnums.EVENT_ONDOUBLECLICK:
                  _loc6_ = EventEnums.EVENT_ONDOUBLECLICK_MSG;
                  break;
               case EventEnums.EVENT_MIDDLECLICK:
                  _loc6_ = EventEnums.EVENT_MIDDLECLICK_MSG;
                  break;
               case EventEnums.EVENT_ONCOLORCHANGE:
                  _loc6_ = EventEnums.EVENT_ONCOLORCHANGE_MSG;
                  break;
               case EventEnums.EVENT_ONENTITYREADY:
                  _loc6_ = EventEnums.EVENT_ONENTITYREADY_MSG;
                  break;
               case EventEnums.EVENT_ONSELECTITEM:
                  _loc6_ = EventEnums.EVENT_ONSELECTITEM_MSG;
                  break;
               case EventEnums.EVENT_ONSELECTEMPTYITEM:
                  _loc6_ = EventEnums.EVENT_ONSELECTEMPTYITEM_MSG;
                  break;
               case EventEnums.EVENT_ONDROP:
                  _loc6_ = EventEnums.EVENT_ONDROP_MSG;
                  break;
               case EventEnums.EVENT_ONCREATETAB:
                  _loc6_ = EventEnums.EVENT_ONCREATETAB_MSG;
                  break;
               case EventEnums.EVENT_ONDELETETAB:
                  _loc6_ = EventEnums.EVENT_ONDELETETAB_MSG;
                  break;
               case EventEnums.EVENT_ONRENAMETAB:
                  _loc6_ = EventEnums.EVENT_ONRENAMETAB_MSG;
                  break;
               case EventEnums.EVENT_ONITEMROLLOVER:
                  _loc6_ = EventEnums.EVENT_ONITEMROLLOVER_MSG;
                  break;
               case EventEnums.EVENT_ONITEMROLLOUT:
                  _loc6_ = EventEnums.EVENT_ONITEMROLLOUT_MSG;
                  break;
               case EventEnums.EVENT_ONITEMRIGHTCLICK:
                  _loc6_ = EventEnums.EVENT_ONITEMRIGHTCLICK_MSG;
                  break;
               case EventEnums.EVENT_ONWHEEL:
                  _loc6_ = EventEnums.EVENT_ONWHEEL_MSG;
                  break;
               case EventEnums.EVENT_ONMOUSEUP:
                  _loc6_ = EventEnums.EVENT_ONMOUSEUP_MSG;
                  break;
               case EventEnums.EVENT_ONMAPELEMENTROLLOUT:
                  _loc6_ = EventEnums.EVENT_ONMAPELEMENTROLLOUT_MSG;
                  break;
               case EventEnums.EVENT_ONMAPELEMENTROLLOVER:
                  _loc6_ = EventEnums.EVENT_ONMAPELEMENTROLLOVER_MSG;
                  break;
               case EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK:
                  _loc6_ = EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK_MSG;
                  break;
               case EventEnums.EVENT_ONMAPMOVE:
                  _loc6_ = EventEnums.EVENT_ONMAPMOVE_MSG;
                  break;
               case EventEnums.EVENT_ONMAPROLLOVER:
                  _loc6_ = EventEnums.EVENT_ONMAPROLLOVER_MSG;
                  break;
               case EventEnums.EVENT_ONCOMPONENTREADY:
                  _loc6_ = EventEnums.EVENT_ONCOMPONENTREADY_MSG;
                  break;
               default:
                  _loc8_ = [EventEnums.EVENT_ONPRESS,EventEnums.EVENT_ONRELEASE,EventEnums.EVENT_ONROLLOUT,EventEnums.EVENT_ONROLLOVER,EventEnums.EVENT_ONRIGHTCLICK,EventEnums.EVENT_ONRELEASEOUTSIDE,EventEnums.EVENT_ONDOUBLECLICK,EventEnums.EVENT_ONCOLORCHANGE,EventEnums.EVENT_ONENTITYREADY,EventEnums.EVENT_ONSELECTITEM,EventEnums.EVENT_ONSELECTEMPTYITEM,EventEnums.EVENT_ONITEMROLLOVER,EventEnums.EVENT_ONITEMROLLOUT,EventEnums.EVENT_ONDROP,EventEnums.EVENT_ONWHEEL,EventEnums.EVENT_ONMOUSEUP,EventEnums.EVENT_ONMAPELEMENTROLLOUT,EventEnums.EVENT_ONMAPELEMENTROLLOVER,EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK,EventEnums.EVENT_ONCREATETAB,EventEnums.EVENT_ONDELETETAB,EventEnums.EVENT_MIDDLECLICK];
                  this._log.warn("[" + this._sUrl + "] " + _loc2_.nodeName + " is an unknow event name" + this.suggest(_loc2_.nodeName,_loc8_));
            }
            if(_loc6_.length)
            {
               _loc7_.push(_loc6_);
            }
            _loc5_ = _loc5_ + 1;
         }
         return _loc7_;
      }
      
      private function getStrataNum(param1:String) : uint {
         var _loc2_:Array = null;
         if(param1 == StrataEnum.STRATA_NAME_LOW)
         {
            return StrataEnum.STRATA_LOW;
         }
         if(param1 == StrataEnum.STRATA_NAME_MEDIUM)
         {
            return StrataEnum.STRATA_MEDIUM;
         }
         if(param1 == StrataEnum.STRATA_NAME_HIGH)
         {
            return StrataEnum.STRATA_HIGH;
         }
         if(param1 == StrataEnum.STRATA_NAME_TOP)
         {
            return StrataEnum.STRATA_TOP;
         }
         if(param1 == StrataEnum.STRATA_NAME_TOOLTIP)
         {
            return StrataEnum.STRATA_TOOLTIP;
         }
         _loc2_ = [StrataEnum.STRATA_NAME_LOW,StrataEnum.STRATA_NAME_MEDIUM,StrataEnum.STRATA_NAME_HIGH,StrataEnum.STRATA_NAME_TOP,StrataEnum.STRATA_NAME_TOOLTIP];
         this._log.warn("[" + this._sUrl + "] " + param1 + " is an unknow strata name" + this.suggest(param1,_loc2_));
         return StrataEnum.STRATA_MEDIUM;
      }
      
      private function suggest(param1:String, param2:Array, param3:uint=5, param4:uint=3) : String {
         var _loc7_:* = NaN;
         var _loc8_:* = 0;
         var _loc5_:* = "";
         var _loc6_:Array = new Array();
         _loc8_ = 0;
         while(_loc8_ < param2.length)
         {
            _loc7_ = Levenshtein.distance(param1.toUpperCase(),param2[_loc8_].toUpperCase());
            if(_loc7_ <= param3)
            {
               _loc6_.push(
                  {
                     "dist":_loc7_,
                     "word":param2[_loc8_]
                  });
            }
            _loc8_++;
         }
         if(_loc6_.length)
         {
            _loc5_ = " (did you mean ";
            _loc6_.sortOn("dist",Array.NUMERIC);
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length-1 && _loc8_ < param4-1)
            {
               _loc5_ = _loc5_ + ("\"" + _loc6_[_loc8_].word + "\"" + (_loc8_ < _loc6_.length-1?", ":""));
               _loc8_++;
            }
            if(_loc6_[_loc8_])
            {
               _loc5_ = _loc5_ + ((_loc8_?"or ":"") + "\"" + _loc6_[_loc8_].word);
            }
            _loc5_ = _loc5_ + "\" ?)";
         }
         return _loc5_;
      }
      
      private function onPreProcessCompleted(param1:Event) : void {
         this.mainProcess();
      }
      
      private function onXmlLoadComplete(param1:ResourceLoadedEvent) : void {
         this.processXml(param1.resource);
      }
      
      private function onXmlLoadError(param1:ResourceErrorEvent) : void {
         dispatchEvent(new ParsingErrorEvent(param1.uri.toString(),param1.errorMsg));
      }
   }
}
