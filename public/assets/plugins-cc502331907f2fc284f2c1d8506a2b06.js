window.log=function o(){if(log.history=log.history||[],log.history.push(arguments),this.console){var l,e=arguments;try{e.callee=o.caller}catch(n){}l=[].slice.call(e),"object"==typeof console.log?log.apply.call(console.log,console,l):console.log.apply(console,l)}},function(o){function l(){}for(var e,n="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(",");e=n.pop();)o[e]=o[e]||l}(function(){try{return console.log(),window.console}catch(o){return window.console={}}}());