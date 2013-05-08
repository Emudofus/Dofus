package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.components.params.TooltipProperties;
   import com.ankamagames.berilia.factories.TooltipsFactory;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.tooltip.TooltipRectangle;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.interfaces.IApplicationContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.logger.Log;


   public class TooltipManager extends Object
   {
         

      public function TooltipManager() {
         super();
      }

      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipManager));

      private static var _tooltips:Array = new Array();

      private static var _tooltipsStrata:Array = new Array();

      private static const TOOLTIP_UI_NAME_PREFIX:String = "tooltip_";

      public static const TOOLTIP_STANDAR_NAME:String = "standard";

      public static var _tooltipCache:Dictionary = new Dictionary();

      public static var _tooltipCacheParam:Dictionary = new Dictionary();

      public static var defaultTooltipUiScript:Class;

      private static var _isInit:Boolean = false;

      public static function show(data:*, target:*, uiModule:UiModule, autoHide:Boolean=true, name:String="standard", point:uint=0, relativePoint:uint=2, offset:int=3, usePrefix:Boolean=true, tooltipMaker:String=null, script:Class=null, makerParam:Object=null, cacheName:String=null, mouseEnabled:Boolean=false, strata:int=4, zoom:Number=1) : Tooltip {
         var cacheNameInfo:Array = null;
         var tooltipCache:Tooltip = null;
         if(!_isInit)
         {
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,onUiRenderComplete);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,onUiUnloadStarted);
            _isInit=true;
         }
         var name:String = (usePrefix?TOOLTIP_UI_NAME_PREFIX:"")+name;
         if(script==null)
         {
            script=defaultTooltipUiScript;
         }
         if(_tooltips[name])
         {
            hide(name);
         }
         if(cacheName)
         {
            cacheNameInfo=cacheName.split("#");
            if((_tooltipCache[cacheNameInfo[0]])&&(cacheNameInfo.length==1)||((_tooltipCache[cacheNameInfo[0]])&&(cacheNameInfo.length<1))&&(_tooltipCacheParam[cacheNameInfo[0]]==cacheNameInfo[1]))
            {
               tooltipCache=_tooltipCache[cacheNameInfo[0]] as Tooltip;
               _tooltips[name]=data;
               _tooltipsStrata[name]=tooltipCache.display.strata;
               Berilia.getInstance().uiList[name]=tooltipCache.display;
               DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(StrataEnum.STRATA_TOOLTIP+1)).addChild(tooltipCache.display);
               if((!(tooltipCache==null))&&(!(tooltipCache.display==null)))
               {
                  tooltipCache.display.x=tooltipCache.display.y=0;
                  tooltipCache.display.scaleX=tooltipCache.display.scaleY=zoom;
                  tooltipCache.display.uiClass.main(new TooltipProperties(tooltipCache,autoHide,getTargetRect(target),point,relativePoint,offset,SecureCenter.secure(data),makerParam,zoom));
               }
               return tooltipCache;
            }
         }
         var tt:Tooltip = TooltipsFactory.create(data,tooltipMaker,script,makerParam);
         if(!tt)
         {
            _log.error("Erreur lors du rendu du tooltip de "+data+" ("+getQualifiedClassName(data)+")");
            return null;
         }
         if(uiModule)
         {
            tt.uiModuleName=uiModule.id;
         }
         _tooltips[name]=data;
         if(mouseEnabled)
         {
            strata=StrataEnum.STRATA_TOP;
         }
         tt.askTooltip(new Callback(onTooltipReady,tt,uiModule,name,data,target,autoHide,point,relativePoint,offset,cacheName,strata,makerParam,zoom));
         return tt;
      }

      public static function hide(name:String="standard") : void {
         if(name==null)
         {
            name=TOOLTIP_STANDAR_NAME;
         }
         if(name.indexOf(TOOLTIP_UI_NAME_PREFIX)==-1)
         {
            name=TOOLTIP_UI_NAME_PREFIX+name;
         }
         if(_tooltips[name])
         {
            Berilia.getInstance().unloadUi(name);
            delete _tooltips[[name]];
         }
      }

      public static function isVisible(name:String) : Boolean {
         if(name.indexOf(TOOLTIP_UI_NAME_PREFIX)==-1)
         {
            name=TOOLTIP_UI_NAME_PREFIX+name;
         }
         return !(_tooltips[name]==null);
      }

      public static function updateContent(ttCacheName:String, ttName:String, data:Object) : void {
         var tooltipCache:Tooltip = null;
         if(isVisible(ttName))
         {
            tooltipCache=_tooltipCache[ttCacheName] as Tooltip;
            if(tooltipCache)
            {
               tooltipCache.display.uiClass.updateContent(new TooltipProperties(tooltipCache,false,null,0,0,0,data,null));
            }
         }
      }

      public static function hideAll() : void {
         var name:String = null;
         var strata:* = 0;
         for (name in _tooltips)
         {
            strata=_tooltipsStrata[name];
            if((strata==StrataEnum.STRATA_TOOLTIP)||(strata==StrataEnum.STRATA_WORLD))
            {
               hide(name);
            }
         }
      }

      public static function clearCache() : void {
         var tt:Tooltip = null;
         var berilia:Berilia = Berilia.getInstance();
         for each (tt in _tooltipCache)
         {
            tt.display.cached=false;
            berilia.uiList[tt.display.name]=tt.display;
            berilia.unloadUi(tt.display.name);
         }
         _tooltipCache=new Dictionary();
         _tooltipCacheParam=new Dictionary();
      }

      private static function onTooltipReady(tt:Tooltip, uiModule:UiModule, name:String, data:*, target:*, autoHide:Boolean, point:uint, relativePoint:uint, offset:int, cacheName:String, strata:int, param:Object, zoom:Number) : void {
         var uiData:UiData = null;
         var cacheNameInfo:Array = null;
         var cacheMode:Boolean = !(cacheName==null);
         var showNow:Boolean = (_tooltips[name])&&(_tooltips[name]===data);
         _tooltipsStrata[name]=strata;
         if((showNow)||(cacheName))
         {
            uiData=new UiData(uiModule,name,null,null);
            uiData.xml=tt.content;
            uiData.uiClass=tt.scriptClass;
            tt.display=Berilia.getInstance().loadUi(uiModule,uiData,name,new TooltipProperties(tt,autoHide,getTargetRect(target),point,relativePoint,offset,SecureCenter.secure(data),param,zoom),true,strata,!showNow,null);
            if(cacheName)
            {
               cacheNameInfo=cacheName.split("#");
               _tooltipCache[cacheNameInfo[0]]=tt;
               if(cacheNameInfo.length>0)
               {
                  _tooltipCacheParam[cacheNameInfo[0]]=cacheNameInfo[1];
               }
               tt.display.cached=true;
               tt.display.cacheAsBitmap=true;
               if(tt.display.scale!=zoom)
               {
                  tt.display.scale=zoom;
               }
            }
            else
            {
               tt.display.scale=zoom;
            }
         }
      }

      private static function getTargetRect(target:*) : TooltipRectangle {
         var coord:Point = null;
         var localCoord:Point = null;
         var sx:* = NaN;
         var sy:* = NaN;
         var inBerilia:* = false;
         var ttrect:TooltipRectangle = null;
         var realtarget:* = SecureCenter.unsecure(target);
         if(realtarget)
         {
            if(realtarget is Rectangle)
            {
               coord=new Point(realtarget.x,realtarget.y);
            }
            else
            {
               if(realtarget.hasOwnProperty("parent"))
               {
                  coord=localToGlobal(realtarget.parent,new Point(realtarget.x,realtarget.y));
               }
               else
               {
                  coord=realtarget.localToGlobal(new Point(realtarget.x,realtarget.y));
               }
            }
            localCoord=Berilia.getInstance().strataTooltip.globalToLocal(coord);
            sx=StageShareManager.stageScaleX;
            sy=StageShareManager.stageScaleY;
            inBerilia=realtarget is DisplayObject?Berilia.getInstance().docMain.contains(realtarget):false;
            ttrect=new TooltipRectangle(localCoord.x*(inBerilia?sx:1),localCoord.y*(inBerilia?sy:1),realtarget.width/sx,realtarget.height/sy);
            return ttrect;
         }
         return null;
      }

      private static function localToGlobal(t:Object, p:Point=null) : Point {
         if(!p)
         {
            p=new Point();
         }
         if(!t.hasOwnProperty("parent"))
         {
            return t.localToGlobal(new Point(t.x,t.y));
         }
         p.x=p.x+t.x;
         p.y=p.y+t.y;
         if((t.parent)&&(!(t.parent is IApplicationContainer)))
         {
            p.x=p.x*t.parent.scaleX;
            p.y=p.y*t.parent.scaleY;
            p=localToGlobal(t.parent,p);
         }
         return p;
      }

      private static function onUiRenderComplete(pEvt:UiRenderEvent) : void {
         TooltipManager.removeTooltipsHiddenByUi(pEvt.uiTarget.name);
      }

      private static function onUiUnloadStarted(pEvt:UiUnloadEvent) : void {
         TooltipManager.removeTooltipsHiddenByUi(pEvt.name);
      }

      private static function removeTooltipsHiddenByUi(uiname:String) : void {
         var name:String = null;
         var strata:* = 0;
         var e:Rectangle = null;
         var berilia:Berilia = Berilia.getInstance();
         var ctr:UiRootContainer = berilia.getUi(uiname);
         if(!ctr)
         {
            return;
         }
         var containerBounds:Rectangle = ctr.getBounds(StageShareManager.stage);
         for (name in _tooltips)
         {
            strata=_tooltipsStrata[name];
            if((strata==StrataEnum.STRATA_TOOLTIP)||(strata==StrataEnum.STRATA_WORLD))
            {
               if(!berilia.getUi(name))
               {
               }
               else
               {
                  e=berilia.getUi(name).getBounds(StageShareManager.stage);
                  if((e.x<containerBounds.x)&&(e.x+e.width>containerBounds.x+containerBounds.width)&&(e.y<containerBounds.y)&&(e.y+e.height>containerBounds.x+containerBounds.height))
                  {
                     hide(name);
                  }
               }
            }
         }
      }


   }

}