package gs
{


   public class OverwriteManager extends Object
   {
         

      public function OverwriteManager() {
         super();
      }

      public static const version:Number = 1;

      public static const NONE:int = 0;

      public static const ALL:int = 1;

      public static const AUTO:int = 2;

      public static const CONCURRENT:int = 3;

      public static var mode:int;

      public static var enabled:Boolean;

      public static function init($mode:int=2) : int {
         if(TweenLite.version<9.29)
         {
            trace("TweenLite warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
         }
         TweenLite.overwriteManager=OverwriteManager;
         mode=$mode;
         enabled=true;
         return mode;
      }

      public static function manageOverwrites($tween:TweenLite, $targetTweens:Array) : void {
         var i:* = 0;
         var tween:TweenLite = null;
         var v:Object = null;
         var p:String = null;
         var vars:Object = $tween.vars;
         var m:int = vars.overwrite==undefined?mode:int(vars.overwrite);
         if((m>2)||($targetTweens==null))
         {
            return;
         }
         var startTime:Number = $tween.startTime;
         var a:Array = [];
         i=$targetTweens.length-1;
         while(i>-1)
         {
            tween=$targetTweens[i];
            if((!(tween==$tween))&&(tween.startTime<=startTime)&&(tween.startTime+tween.duration*1000/tween.combinedTimeScale<startTime))
            {
               a[a.length]=tween;
            }
            i--;
         }
         if(a.length==0)
         {
            return;
         }
         if(m==AUTO)
         {
            if(vars.isTV==true)
            {
               vars=vars.exposedProps;
            }
            v={};
            for (p in vars)
            {
               if((p=="ease")||(p=="delay")||(p=="overwrite")||(p=="onComplete")||(p=="onCompleteParams")||(p=="runBackwards")||(p=="persist")||(p=="onUpdate")||(p=="onUpdateParams")||(p=="timeScale")||(p=="onStart")||(p=="onStartParams")||(p=="renderOnStart")||(p=="proxiedEase")||(p=="easeParams")||(p=="onCompleteAll")||(p=="onCompleteAllParams")||(p=="yoyo")||(p=="loop")||(p=="onCompleteListener")||(p=="onStartListener")||(p=="onUpdateListener"))
               {
               }
               else
               {
                  v[p]=1;
                  if(p=="shortRotate")
                  {
                     v.rotation=1;
                  }
                  else
                  {
                     if(p=="removeTint")
                     {
                        v.tint=1;
                     }
                     else
                     {
                        if(p=="autoAlpha")
                        {
                           v.alpha=1;
                           v.visible=1;
                        }
                     }
                  }
               }
            }
            i=a.length-1;
            while(i>-1)
            {
               a[i].killVars(v);
               i--;
            }
         }
         else
         {
            i=a.length-1;
            while(i>-1)
            {
               a[i].enabled=false;
               i--;
            }
         }
      }

      public static function killVars($killVars:Object, $vars:Object, $tweens:Array, $subTweens:Array, $filters:Array) : void {
         var i:* = 0;
         var p:String = null;
         i=$subTweens.length-1;
         while(i>-1)
         {
            if($killVars[$subTweens[i].name]!=undefined)
            {
               $subTweens.splice(i,1);
            }
            i--;
         }
         i=$tweens.length-1;
         while(i>-1)
         {
            if($killVars[$tweens[i][4]]!=undefined)
            {
               $tweens.splice(i,1);
            }
            i--;
         }
         i=$filters.length-1;
         while(i>-1)
         {
            if($killVars[$filters[i].name]!=undefined)
            {
               $filters.splice(i,1);
            }
            i--;
         }
         for (p in $killVars)
         {
            delete $vars[[p]];
         }
      }


   }

}