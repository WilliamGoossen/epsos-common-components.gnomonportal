/*
 * jQuery JavaScript Library v1.3.2
 * http://jquery.com/
 *
 * Copyright (c) 2009 John Resig
 * Dual licensed under the MIT and GPL licenses.
 * http://docs.jquery.com/License
 *
 * Date: 2009-02-19 17:34:21 -0500 (Thu, 19 Feb 2009)
 * Revision: 6246
 */
(function(){var l=this,g,y=l.jQuery,p=l.$,o=l.jQuery=l.$=function(E,F){return new o.fn.init(E,F)},D=/^[^<]*(<(.|\s)+>)[^>]*$|^#([\w-]+)$/,f=/^.[^:#\[\.,]*$/;o.fn=o.prototype={init:function(E,H){E=E||document;if(E.nodeType){this[0]=E;this.length=1;this.context=E;return this}if(typeof E==="string"){var G=D.exec(E);if(G&&(G[1]||!H)){if(G[1]){E=o.clean([G[1]],H)}else{var I=document.getElementById(G[3]);if(I&&I.id!=G[3]){return o().find(E)}var F=o(I||[]);F.context=document;F.selector=E;return F}}else{return o(H).find(E)}}else{if(o.isFunction(E)){return o(document).ready(E)}}if(E.selector&&E.context){this.selector=E.selector;this.context=E.context}return this.setArray(o.isArray(E)?E:o.makeArray(E))},selector:"",jquery:"1.3.2",size:function(){return this.length},get:function(E){return E===g?Array.prototype.slice.call(this):this[E]},pushStack:function(F,H,E){var G=o(F);G.prevObject=this;G.context=this.context;if(H==="find"){G.selector=this.selector+(this.selector?" ":"")+E}else{if(H){G.selector=this.selector+"."+H+"("+E+")"}}return G},setArray:function(E){this.length=0;Array.prototype.push.apply(this,E);return this},each:function(F,E){return o.each(this,F,E)},index:function(E){return o.inArray(E&&E.jquery?E[0]:E,this)},attr:function(F,H,G){var E=F;if(typeof F==="string"){if(H===g){return this[0]&&o[G||"attr"](this[0],F)}else{E={};E[F]=H}}return this.each(function(I){for(F in E){o.attr(G?this.style:this,F,o.prop(this,E[F],G,I,F))}})},css:function(E,F){if((E=="width"||E=="height")&&parseFloat(F)<0){F=g}return this.attr(E,F,"curCSS")},text:function(F){if(typeof F!=="object"&&F!=null){return this.empty().append((this[0]&&this[0].ownerDocument||document).createTextNode(F))}var E="";o.each(F||this,function(){o.each(this.childNodes,function(){if(this.nodeType!=8){E+=this.nodeType!=1?this.nodeValue:o.fn.text([this])}})});return E},wrapAll:function(E){if(this[0]){var F=o(E,this[0].ownerDocument).clone();if(this[0].parentNode){F.insertBefore(this[0])}F.map(function(){var G=this;while(G.firstChild){G=G.firstChild}return G}).append(this)}return this},wrapInner:function(E){return this.each(function(){o(this).contents().wrapAll(E)})},wrap:function(E){return this.each(function(){o(this).wrapAll(E)})},append:function(){return this.domManip(arguments,true,function(E){if(this.nodeType==1){this.appendChild(E)}})},prepend:function(){return this.domManip(arguments,true,function(E){if(this.nodeType==1){this.insertBefore(E,this.firstChild)}})},before:function(){return this.domManip(arguments,false,function(E){this.parentNode.insertBefore(E,this)})},after:function(){return this.domManip(arguments,false,function(E){this.parentNode.insertBefore(E,this.nextSibling)})},end:function(){return this.prevObject||o([])},push:[].push,sort:[].sort,splice:[].splice,find:function(E){if(this.length===1){var F=this.pushStack([],"find",E);F.length=0;o.find(E,this[0],F);return F}else{return this.pushStack(o.unique(o.map(this,function(G){return o.find(E,G)})),"find",E)}},clone:function(G){var E=this.map(function(){if(!o.support.noCloneEvent&&!o.isXMLDoc(this)){var I=this.outerHTML;if(!I){var J=this.ownerDocument.createElement("div");J.appendChild(this.cloneNode(true));I=J.innerHTML}return o.clean([I.replace(/ jQuery\d+="(?:\d+|null)"/g,"").replace(/^\s*/,"")])[0]}else{return this.cloneNode(true)}});if(G===true){var H=this.find("*").andSelf(),F=0;E.find("*").andSelf().each(function(){if(this.nodeName!==H[F].nodeName){return}var I=o.data(H[F],"events");for(var K in I){for(var J in I[K]){o.event.add(this,K,I[K][J],I[K][J].data)}}F++})}return E},filter:function(E){return this.pushStack(o.isFunction(E)&&o.grep(this,function(G,F){return E.call(G,F)})||o.multiFilter(E,o.grep(this,function(F){return F.nodeType===1})),"filter",E)},closest:function(E){var G=o.expr.match.POS.test(E)?o(E):null,F=0;return this.map(function(){var H=this;while(H&&H.ownerDocument){if(G?G.index(H)>-1:o(H).is(E)){o.data(H,"closest",F);return H}H=H.parentNode;F++}})},not:function(E){if(typeof E==="string"){if(f.test(E)){return this.pushStack(o.multiFilter(E,this,true),"not",E)}else{E=o.multiFilter(E,this)}}var F=E.length&&E[E.length-1]!==g&&!E.nodeType;return this.filter(function(){return F?o.inArray(this,E)<0:this!=E})},add:function(E){return this.pushStack(o.unique(o.merge(this.get(),typeof E==="string"?o(E):o.makeArray(E))))},is:function(E){return !!E&&o.multiFilter(E,this).length>0},hasClass:function(E){return !!E&&this.is("."+E)},val:function(K){if(K===g){var E=this[0];if(E){if(o.nodeName(E,"option")){return(E.attributes.value||{}).specified?E.value:E.text}if(o.nodeName(E,"select")){var I=E.selectedIndex,L=[],M=E.options,H=E.type=="select-one";if(I<0){return null}for(var F=H?I:0,J=H?I+1:M.length;F<J;F++){var G=M[F];if(G.selected){K=o(G).val();if(H){return K}L.push(K)}}return L}return(E.value||"").replace(/\r/g,"")}return g}if(typeof K==="number"){K+=""}return this.each(function(){if(this.nodeType!=1){return}if(o.isArray(K)&&/radio|checkbox/.test(this.type)){this.checked=(o.inArray(this.value,K)>=0||o.inArray(this.name,K)>=0)}else{if(o.nodeName(this,"select")){var N=o.makeArray(K);o("option",this).each(function(){this.selected=(o.inArray(this.value,N)>=0||o.inArray(this.text,N)>=0)});if(!N.length){this.selectedIndex=-1}}else{this.value=K}}})},html:function(E){return E===g?(this[0]?this[0].innerHTML.replace(/ jQuery\d+="(?:\d+|null)"/g,""):null):this.empty().append(E)},replaceWith:function(E){return this.after(E).remove()},eq:function(E){return this.slice(E,+E+1)},slice:function(){return this.pushStack(Array.prototype.slice.apply(this,arguments),"slice",Array.prototype.slice.call(arguments).join(","))},map:function(E){return this.pushStack(o.map(this,function(G,F){return E.call(G,F,G)}))},andSelf:function(){return this.add(this.prevObject)},domManip:function(J,M,L){if(this[0]){var I=(this[0].ownerDocument||this[0]).createDocumentFragment(),F=o.clean(J,(this[0].ownerDocument||this[0]),I),H=I.firstChild;if(H){for(var G=0,E=this.length;G<E;G++){L.call(K(this[G],H),this.length>1||G>0?I.cloneNode(true):I)}}if(F){o.each(F,z)}}return this;function K(N,O){return M&&o.nodeName(N,"table")&&o.nodeName(O,"tr")?(N.getElementsByTagName("tbody")[0]||N.appendChild(N.ownerDocument.createElement("tbody"))):N}}};o.fn.init.prototype=o.fn;function z(E,F){if(F.src){o.ajax({url:F.src,async:false,dataType:"script"})}else{o.globalEval(F.text||F.textContent||F.innerHTML||"")}if(F.parentNode){F.parentNode.removeChild(F)}}function e(){return +new Date}o.extend=o.fn.extend=function(){var J=arguments[0]||{},H=1,I=arguments.length,E=false,G;if(typeof J==="boolean"){E=J;J=arguments[1]||{};H=2}if(typeof J!=="object"&&!o.isFunction(J)){J={}}if(I==H){J=this;--H}for(;H<I;H++){if((G=arguments[H])!=null){for(var F in G){var K=J[F],L=G[F];if(J===L){continue}if(E&&L&&typeof L==="object"&&!L.nodeType){J[F]=o.extend(E,K||(L.length!=null?[]:{}),L)}else{if(L!==g){J[F]=L}}}}}return J};var b=/z-?index|font-?weight|opacity|zoom|line-?height/i,q=document.defaultView||{},s=Object.prototype.toString;o.extend({noConflict:function(E){l.$=p;if(E){l.jQuery=y}return o},isFunction:function(E){return s.call(E)==="[object Function]"},isArray:function(E){return s.call(E)==="[object Array]"},isXMLDoc:function(E){return E.nodeType===9&&E.documentElement.nodeName!=="HTML"||!!E.ownerDocument&&o.isXMLDoc(E.ownerDocument)},globalEval:function(G){if(G&&/\S/.test(G)){var F=document.getElementsByTagName("head")[0]||document.documentElement,E=document.createElement("script");E.type="text/javascript";if(o.support.scriptEval){E.appendChild(document.createTextNode(G))}else{E.text=G}F.insertBefore(E,F.firstChild);F.removeChild(E)}},nodeName:function(F,E){return F.nodeName&&F.nodeName.toUpperCase()==E.toUpperCase()},each:function(G,K,F){var E,H=0,I=G.length;if(F){if(I===g){for(E in G){if(K.apply(G[E],F)===false){break}}}else{for(;H<I;){if(K.apply(G[H++],F)===false){break}}}}else{if(I===g){for(E in G){if(K.call(G[E],E,G[E])===false){break}}}else{for(var J=G[0];H<I&&K.call(J,H,J)!==false;J=G[++H]){}}}return G},prop:function(H,I,G,F,E){if(o.isFunction(I)){I=I.call(H,F)}return typeof I==="number"&&G=="curCSS"&&!b.test(E)?I+"px":I},className:{add:function(E,F){o.each((F||"").split(/\s+/),function(G,H){if(E.nodeType==1&&!o.className.has(E.className,H)){E.className+=(E.className?" ":"")+H}})},remove:function(E,F){if(E.nodeType==1){E.className=F!==g?o.grep(E.className.split(/\s+/),function(G){return !o.className.has(F,G)}).join(" "):""}},has:function(F,E){return F&&o.inArray(E,(F.className||F).toString().split(/\s+/))>-1}},swap:function(H,G,I){var E={};for(var F in G){E[F]=H.style[F];H.style[F]=G[F]}I.call(H);for(var F in G){H.style[F]=E[F]}},css:function(H,F,J,E){if(F=="width"||F=="height"){var L,G={position:"absolute",visibility:"hidden",display:"block"},K=F=="width"?["Left","Right"]:["Top","Bottom"];function I(){L=F=="width"?H.offsetWidth:H.offsetHeight;if(E==="border"){return}o.each(K,function(){if(!E){L-=parseFloat(o.curCSS(H,"padding"+this,true))||0}if(E==="margin"){L+=parseFloat(o.curCSS(H,"margin"+this,true))||0}else{L-=parseFloat(o.curCSS(H,"border"+this+"Width",true))||0}})}if(H.offsetWidth!==0){I()}else{o.swap(H,G,I)}return Math.max(0,Math.round(L))}return o.curCSS(H,F,J)},curCSS:function(I,F,G){var L,E=I.style;if(F=="opacity"&&!o.support.opacity){L=o.attr(E,"opacity");return L==""?"1":L}if(F.match(/float/i)){F=w}if(!G&&E&&E[F]){L=E[F]}else{if(q.getComputedStyle){if(F.match(/float/i)){F="float"}F=F.replace(/([A-Z])/g,"-$1").toLowerCase();var M=q.getComputedStyle(I,null);if(M){L=M.getPropertyValue(F)}if(F=="opacity"&&L==""){L="1"}}else{if(I.currentStyle){var J=F.replace(/\-(\w)/g,function(N,O){return O.toUpperCase()});L=I.currentStyle[F]||I.currentStyle[J];if(!/^\d+(px)?$/i.test(L)&&/^\d/.test(L)){var H=E.left,K=I.runtimeStyle.left;I.runtimeStyle.left=I.currentStyle.left;E.left=L||0;L=E.pixelLeft+"px";E.left=H;I.runtimeStyle.left=K}}}}return L},clean:function(F,K,I){K=K||document;if(typeof K.createElement==="undefined"){K=K.ownerDocument||K[0]&&K[0].ownerDocument||document}if(!I&&F.length===1&&typeof F[0]==="string"){var H=/^<(\w+)\s*\/?>$/.exec(F[0]);if(H){return[K.createElement(H[1])]}}var G=[],E=[],L=K.createElement("div");o.each(F,function(P,S){if(typeof S==="number"){S+=""}if(!S){return}if(typeof S==="string"){S=S.replace(/(<(\w+)[^>]*?)\/>/g,function(U,V,T){return T.match(/^(abbr|br|col|img|input|link|meta|param|hr|area|embed)$/i)?U:V+"></"+T+">"});var O=S.replace(/^\s+/,"").substring(0,10).toLowerCase();var Q=!O.indexOf("<opt")&&[1,"<select multiple='multiple'>","</select>"]||!O.indexOf("<leg")&&[1,"<fieldset>","</fieldset>"]||O.match(/^<(thead|tbody|tfoot|colg|cap)/)&&[1,"<table>","</table>"]||!O.indexOf("<tr")&&[2,"<table><tbody>","</tbody></table>"]||(!O.indexOf("<td")||!O.indexOf("<th"))&&[3,"<table><tbody><tr>","</tr></tbody></table>"]||!O.indexOf("<col")&&[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"]||!o.support.htmlSerialize&&[1,"div<div>","</div>"]||[0,"",""];L.innerHTML=Q[1]+S+Q[2];while(Q[0]--){L=L.lastChild}if(!o.support.tbody){var R=/<tbody/i.test(S),N=!O.indexOf("<table")&&!R?L.firstChild&&L.firstChild.childNodes:Q[1]=="<table>"&&!R?L.childNodes:[];for(var M=N.length-1;M>=0;--M){if(o.nodeName(N[M],"tbody")&&!N[M].childNodes.length){N[M].parentNode.removeChild(N[M])}}}if(!o.support.leadingWhitespace&&/^\s/.test(S)){L.insertBefore(K.createTextNode(S.match(/^\s*/)[0]),L.firstChild)}S=o.makeArray(L.childNodes)}if(S.nodeType){G.push(S)}else{G=o.merge(G,S)}});if(I){for(var J=0;G[J];J++){if(o.nodeName(G[J],"script")&&(!G[J].type||G[J].type.toLowerCase()==="text/javascript")){E.push(G[J].parentNode?G[J].parentNode.removeChild(G[J]):G[J])}else{if(G[J].nodeType===1){G.splice.apply(G,[J+1,0].concat(o.makeArray(G[J].getElementsByTagName("script"))))}I.appendChild(G[J])}}return E}return G},attr:function(J,G,K){if(!J||J.nodeType==3||J.nodeType==8){return g}var H=!o.isXMLDoc(J),L=K!==g;G=H&&o.props[G]||G;if(J.tagName){var F=/href|src|style/.test(G);if(G=="selected"&&J.parentNode){J.parentNode.selectedIndex}if(G in J&&H&&!F){if(L){if(G=="type"&&o.nodeName(J,"input")&&J.parentNode){throw"type property can't be changed"}J[G]=K}if(o.nodeName(J,"form")&&J.getAttributeNode(G)){return J.getAttributeNode(G).nodeValue}if(G=="tabIndex"){var I=J.getAttributeNode("tabIndex");return I&&I.specified?I.value:J.nodeName.match(/(button|input|object|select|textarea)/i)?0:J.nodeName.match(/^(a|area)$/i)&&J.href?0:g}return J[G]}if(!o.support.style&&H&&G=="style"){return o.attr(J.style,"cssText",K)}if(L){J.setAttribute(G,""+K)}var E=!o.support.hrefNormalized&&H&&F?J.getAttribute(G,2):J.getAttribute(G);return E===null?g:E}if(!o.support.opacity&&G=="opacity"){if(L){J.zoom=1;J.filter=(J.filter||"").replace(/alpha\([^)]*\)/,"")+(parseInt(K)+""=="NaN"?"":"alpha(opacity="+K*100+")")}return J.filter&&J.filter.indexOf("opacity=")>=0?(parseFloat(J.filter.match(/opacity=([^)]*)/)[1])/100)+"":""}G=G.replace(/-([a-z])/ig,function(M,N){return N.toUpperCase()});if(L){J[G]=K}return J[G]},trim:function(E){return(E||"").replace(/^\s+|\s+$/g,"")},makeArray:function(G){var E=[];if(G!=null){var F=G.length;if(F==null||typeof G==="string"||o.isFunction(G)||G.setInterval){E[0]=G}else{while(F){E[--F]=G[F]}}}return E},inArray:function(G,H){for(var E=0,F=H.length;E<F;E++){if(H[E]===G){return E}}return -1},merge:function(H,E){var F=0,G,I=H.length;if(!o.support.getAll){while((G=E[F++])!=null){if(G.nodeType!=8){H[I++]=G}}}else{while((G=E[F++])!=null){H[I++]=G}}return H},unique:function(K){var F=[],E={};try{for(var G=0,H=K.length;G<H;G++){var J=o.data(K[G]);if(!E[J]){E[J]=true;F.push(K[G])}}}catch(I){F=K}return F},grep:function(F,J,E){var G=[];for(var H=0,I=F.length;H<I;H++){if(!E!=!J(F[H],H)){G.push(F[H])}}return G},map:function(E,J){var F=[];for(var G=0,H=E.length;G<H;G++){var I=J(E[G],G);if(I!=null){F[F.length]=I}}return F.concat.apply([],F)}});var C=navigator.userAgent.toLowerCase();o.browser={version:(C.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/)||[0,"0"])[1],safari:/webkit/.test(C),opera:/opera/.test(C),msie:/msie/.test(C)&&!/opera/.test(C),mozilla:/mozilla/.test(C)&&!/(compatible|webkit)/.test(C)};o.each({parent:function(E){return E.parentNode},parents:function(E){return o.dir(E,"parentNode")},next:function(E){return o.nth(E,2,"nextSibling")},prev:function(E){return o.nth(E,2,"previousSibling")},nextAll:function(E){return o.dir(E,"nextSibling")},prevAll:function(E){return o.dir(E,"previousSibling")},siblings:function(E){return o.sibling(E.parentNode.firstChild,E)},children:function(E){return o.sibling(E.firstChild)},contents:function(E){return o.nodeName(E,"iframe")?E.contentDocument||E.contentWindow.document:o.makeArray(E.childNodes)}},function(E,F){o.fn[E]=function(G){var H=o.map(this,F);if(G&&typeof G=="string"){H=o.multiFilter(G,H)}return this.pushStack(o.unique(H),E,G)}});o.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(E,F){o.fn[E]=function(G){var J=[],L=o(G);for(var K=0,H=L.length;K<H;K++){var I=(K>0?this.clone(true):this).get();o.fn[F].apply(o(L[K]),I);J=J.concat(I)}return this.pushStack(J,E,G)}});o.each({removeAttr:function(E){o.attr(this,E,"");if(this.nodeType==1){this.removeAttribute(E)}},addClass:function(E){o.className.add(this,E)},removeClass:function(E){o.className.remove(this,E)},toggleClass:function(F,E){if(typeof E!=="boolean"){E=!o.className.has(this,F)}o.className[E?"add":"remove"](this,F)},remove:function(E){if(!E||o.filter(E,[this]).length){o("*",this).add([this]).each(function(){o.event.remove(this);o.removeData(this)});if(this.parentNode){this.parentNode.removeChild(this)}}},empty:function(){o(this).children().remove();while(this.firstChild){this.removeChild(this.firstChild)}}},function(E,F){o.fn[E]=function(){return this.each(F,arguments)}});function j(E,F){return E[0]&&parseInt(o.curCSS(E[0],F,true),10)||0}var h="jQuery"+e(),v=0,A={};o.extend({cache:{},data:function(F,E,G){F=F==l?A:F;var H=F[h];if(!H){H=F[h]=++v}if(E&&!o.cache[H]){o.cache[H]={}}if(G!==g){o.cache[H][E]=G}return E?o.cache[H][E]:H},removeData:function(F,E){F=F==l?A:F;var H=F[h];if(E){if(o.cache[H]){delete o.cache[H][E];E="";for(E in o.cache[H]){break}if(!E){o.removeData(F)}}}else{try{delete F[h]}catch(G){if(F.removeAttribute){F.removeAttribute(h)}}delete o.cache[H]}},queue:function(F,E,H){if(F){E=(E||"fx")+"queue";var G=o.data(F,E);if(!G||o.isArray(H)){G=o.data(F,E,o.makeArray(H))}else{if(H){G.push(H)}}}return G},dequeue:function(H,G){var E=o.queue(H,G),F=E.shift();if(!G||G==="fx"){F=E[0]}if(F!==g){F.call(H)}}});o.fn.extend({data:function(E,G){var H=E.split(".");H[1]=H[1]?"."+H[1]:"";if(G===g){var F=this.triggerHandler("getData"+H[1]+"!",[H[0]]);if(F===g&&this.length){F=o.data(this[0],E)}return F===g&&H[1]?this.data(H[0]):F}else{return this.trigger("setData"+H[1]+"!",[H[0],G]).each(function(){o.data(this,E,G)})}},removeData:function(E){return this.each(function(){o.removeData(this,E)})},queue:function(E,F){if(typeof E!=="string"){F=E;E="fx"}if(F===g){return o.queue(this[0],E)}return this.each(function(){var G=o.queue(this,E,F);if(E=="fx"&&G.length==1){G[0].call(this)}})},dequeue:function(E){return this.each(function(){o.dequeue(this,E)})}});
/*
 * Sizzle CSS Selector Engine - v0.9.3
 *  Copyright 2009, The Dojo Foundation
 *  Released under the MIT, BSD, and GPL Licenses.
 *  More information: http://sizzlejs.com/
 */
(function(){var R=/((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^[\]]*\]|['"][^'"]*['"]|[^[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?/g,L=0,H=Object.prototype.toString;var F=function(Y,U,ab,ac){ab=ab||[];U=U||document;if(U.nodeType!==1&&U.nodeType!==9){return[]}if(!Y||typeof Y!=="string"){return ab}var Z=[],W,af,ai,T,ad,V,X=true;R.lastIndex=0;while((W=R.exec(Y))!==null){Z.push(W[1]);if(W[2]){V=RegExp.rightContext;break}}if(Z.length>1&&M.exec(Y)){if(Z.length===2&&I.relative[Z[0]]){af=J(Z[0]+Z[1],U)}else{af=I.relative[Z[0]]?[U]:F(Z.shift(),U);while(Z.length){Y=Z.shift();if(I.relative[Y]){Y+=Z.shift()}af=J(Y,af)}}}else{var ae=ac?{expr:Z.pop(),set:E(ac)}:F.find(Z.pop(),Z.length===1&&U.parentNode?U.parentNode:U,Q(U));af=F.filter(ae.expr,ae.set);if(Z.length>0){ai=E(af)}else{X=false}while(Z.length){var ah=Z.pop(),ag=ah;if(!I.relative[ah]){ah=""}else{ag=Z.pop()}if(ag==null){ag=U}I.relative[ah](ai,ag,Q(U))}}if(!ai){ai=af}if(!ai){throw"Syntax error, unrecognized expression: "+(ah||Y)}if(H.call(ai)==="[object Array]"){if(!X){ab.push.apply(ab,ai)}else{if(U.nodeType===1){for(var aa=0;ai[aa]!=null;aa++){if(ai[aa]&&(ai[aa]===true||ai[aa].nodeType===1&&K(U,ai[aa]))){ab.push(af[aa])}}}else{for(var aa=0;ai[aa]!=null;aa++){if(ai[aa]&&ai[aa].nodeType===1){ab.push(af[aa])}}}}}else{E(ai,ab)}if(V){F(V,U,ab,ac);if(G){hasDuplicate=false;ab.sort(G);if(hasDuplicate){for(var aa=1;aa<ab.length;aa++){if(ab[aa]===ab[aa-1]){ab.splice(aa--,1)}}}}}return ab};F.matches=function(T,U){return F(T,null,null,U)};F.find=function(aa,T,ab){var Z,X;if(!aa){return[]}for(var W=0,V=I.order.length;W<V;W++){var Y=I.order[W],X;if((X=I.match[Y].exec(aa))){var U=RegExp.leftContext;if(U.substr(U.length-1)!=="\\"){X[1]=(X[1]||"").replace(/\\/g,"");Z=I.find[Y](X,T,ab);if(Z!=null){aa=aa.replace(I.match[Y],"");break}}}}if(!Z){Z=T.getElementsByTagName("*")}return{set:Z,expr:aa}};F.filter=function(ad,ac,ag,W){var V=ad,ai=[],aa=ac,Y,T,Z=ac&&ac[0]&&Q(ac[0]);while(ad&&ac.length){for(var ab in I.filter){if((Y=I.match[ab].exec(ad))!=null){var U=I.filter[ab],ah,af;T=false;if(aa==ai){ai=[]}if(I.preFilter[ab]){Y=I.preFilter[ab](Y,aa,ag,ai,W,Z);if(!Y){T=ah=true}else{if(Y===true){continue}}}if(Y){for(var X=0;(af=aa[X])!=null;X++){if(af){ah=U(af,Y,X,aa);var ae=W^!!ah;if(ag&&ah!=null){if(ae){T=true}else{aa[X]=false}}else{if(ae){ai.push(af);T=true}}}}}if(ah!==g){if(!ag){aa=ai}ad=ad.replace(I.match[ab],"");if(!T){return[]}break}}}if(ad==V){if(T==null){throw"Syntax error, unrecognized expression: "+ad}else{break}}V=ad}return aa};var I=F.selectors={order:["ID","NAME","TAG"],match:{ID:/#((?:[\w\u00c0-\uFFFF_-]|\\.)+)/,CLASS:/\.((?:[\w\u00c0-\uFFFF_-]|\\.)+)/,NAME:/\[name=['"]*((?:[\w\u00c0-\uFFFF_-]|\\.)+)['"]*\]/,ATTR:/\[\s*((?:[\w\u00c0-\uFFFF_-]|\\.)+)\s*(?:(\S?=)\s*(['"]*)(.*?)\3|)\s*\]/,TAG:/^((?:[\w\u00c0-\uFFFF\*_-]|\\.)+)/,CHILD:/:(only|nth|last|first)-child(?:\((even|odd|[\dn+-]*)\))?/,POS:/:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^-]|$)/,PSEUDO:/:((?:[\w\u00c0-\uFFFF_-]|\\.)+)(?:\((['"]*)((?:\([^\)]+\)|[^\2\(\)]*)+)\2\))?/},attrMap:{"class":"className","for":"htmlFor"},attrHandle:{href:function(T){return T.getAttribute("href")}},relative:{"+":function(aa,T,Z){var X=typeof T==="string",ab=X&&!/\W/.test(T),Y=X&&!ab;if(ab&&!Z){T=T.toUpperCase()}for(var W=0,V=aa.length,U;W<V;W++){if((U=aa[W])){while((U=U.previousSibling)&&U.nodeType!==1){}aa[W]=Y||U&&U.nodeName===T?U||false:U===T}}if(Y){F.filter(T,aa,true)}},">":function(Z,U,aa){var X=typeof U==="string";if(X&&!/\W/.test(U)){U=aa?U:U.toUpperCase();for(var V=0,T=Z.length;V<T;V++){var Y=Z[V];if(Y){var W=Y.parentNode;Z[V]=W.nodeName===U?W:false}}}else{for(var V=0,T=Z.length;V<T;V++){var Y=Z[V];if(Y){Z[V]=X?Y.parentNode:Y.parentNode===U}}if(X){F.filter(U,Z,true)}}},"":function(W,U,Y){var V=L++,T=S;if(!U.match(/\W/)){var X=U=Y?U:U.toUpperCase();T=P}T("parentNode",U,V,W,X,Y)},"~":function(W,U,Y){var V=L++,T=S;if(typeof U==="string"&&!U.match(/\W/)){var X=U=Y?U:U.toUpperCase();T=P}T("previousSibling",U,V,W,X,Y)}},find:{ID:function(U,V,W){if(typeof V.getElementById!=="undefined"&&!W){var T=V.getElementById(U[1]);return T?[T]:[]}},NAME:function(V,Y,Z){if(typeof Y.getElementsByName!=="undefined"){var U=[],X=Y.getElementsByName(V[1]);for(var W=0,T=X.length;W<T;W++){if(X[W].getAttribute("name")===V[1]){U.push(X[W])}}return U.length===0?null:U}},TAG:function(T,U){return U.getElementsByTagName(T[1])}},preFilter:{CLASS:function(W,U,V,T,Z,aa){W=" "+W[1].replace(/\\/g,"")+" ";if(aa){return W}for(var X=0,Y;(Y=U[X])!=null;X++){if(Y){if(Z^(Y.className&&(" "+Y.className+" ").indexOf(W)>=0)){if(!V){T.push(Y)}}else{if(V){U[X]=false}}}}return false},ID:function(T){return T[1].replace(/\\/g,"")},TAG:function(U,T){for(var V=0;T[V]===false;V++){}return T[V]&&Q(T[V])?U[1]:U[1].toUpperCase()},CHILD:function(T){if(T[1]=="nth"){var U=/(-?)(\d*)n((?:\+|-)?\d*)/.exec(T[2]=="even"&&"2n"||T[2]=="odd"&&"2n+1"||!/\D/.test(T[2])&&"0n+"+T[2]||T[2]);T[2]=(U[1]+(U[2]||1))-0;T[3]=U[3]-0}T[0]=L++;return T},ATTR:function(X,U,V,T,Y,Z){var W=X[1].replace(/\\/g,"");if(!Z&&I.attrMap[W]){X[1]=I.attrMap[W]}if(X[2]==="~="){X[4]=" "+X[4]+" "}return X},PSEUDO:function(X,U,V,T,Y){if(X[1]==="not"){if(X[3].match(R).length>1||/^\w/.test(X[3])){X[3]=F(X[3],null,null,U)}else{var W=F.filter(X[3],U,V,true^Y);if(!V){T.push.apply(T,W)}return false}}else{if(I.match.POS.test(X[0])||I.match.CHILD.test(X[0])){return true}}return X},POS:function(T){T.unshift(true);return T}},filters:{enabled:function(T){return T.disabled===false&&T.type!=="hidden"},disabled:function(T){return T.disabled===true},checked:function(T){return T.checked===true},selected:function(T){T.parentNode.selectedIndex;return T.selected===true},parent:function(T){return !!T.firstChild},empty:function(T){return !T.firstChild},has:function(V,U,T){return !!F(T[3],V).length},header:function(T){return/h\d/i.test(T.nodeName)},text:function(T){return"text"===T.type},radio:function(T){return"radio"===T.type},checkbox:function(T){return"checkbox"===T.type},file:function(T){return"file"===T.type},password:function(T){return"password"===T.type},submit:function(T){return"submit"===T.type},image:function(T){return"image"===T.type},reset:function(T){return"reset"===T.type},button:function(T){return"button"===T.type||T.nodeName.toUpperCase()==="BUTTON"},input:function(T){return/input|select|textarea|button/i.test(T.nodeName)}},setFilters:{first:function(U,T){return T===0},last:function(V,U,T,W){return U===W.length-1},even:function(U,T){return T%2===0},odd:function(U,T){return T%2===1},lt:function(V,U,T){return U<T[3]-0},gt:function(V,U,T){return U>T[3]-0},nth:function(V,U,T){return T[3]-0==U},eq:function(V,U,T){return T[3]-0==U}},filter:{PSEUDO:function(Z,V,W,aa){var U=V[1],X=I.filters[U];if(X){return X(Z,W,V,aa)}else{if(U==="contains"){return(Z.textContent||Z.innerText||"").indexOf(V[3])>=0}else{if(U==="not"){var Y=V[3];for(var W=0,T=Y.length;W<T;W++){if(Y[W]===Z){return false}}return true}}}},CHILD:function(T,W){var Z=W[1],U=T;switch(Z){case"only":case"first":while(U=U.previousSibling){if(U.nodeType===1){return false}}if(Z=="first"){return true}U=T;case"last":while(U=U.nextSibling){if(U.nodeType===1){return false}}return true;case"nth":var V=W[2],ac=W[3];if(V==1&&ac==0){return true}var Y=W[0],ab=T.parentNode;if(ab&&(ab.sizcache!==Y||!T.nodeIndex)){var X=0;for(U=ab.firstChild;U;U=U.nextSibling){if(U.nodeType===1){U.nodeIndex=++X}}ab.sizcache=Y}var aa=T.nodeIndex-ac;if(V==0){return aa==0}else{return(aa%V==0&&aa/V>=0)}}},ID:function(U,T){return U.nodeType===1&&U.getAttribute("id")===T},TAG:function(U,T){return(T==="*"&&U.nodeType===1)||U.nodeName===T},CLASS:function(U,T){return(" "+(U.className||U.getAttribute("class"))+" ").indexOf(T)>-1},ATTR:function(Y,W){var V=W[1],T=I.attrHandle[V]?I.attrHandle[V](Y):Y[V]!=null?Y[V]:Y.getAttribute(V),Z=T+"",X=W[2],U=W[4];return T==null?X==="!=":X==="="?Z===U:X==="*="?Z.indexOf(U)>=0:X==="~="?(" "+Z+" ").indexOf(U)>=0:!U?Z&&T!==false:X==="!="?Z!=U:X==="^="?Z.indexOf(U)===0:X==="$="?Z.substr(Z.length-U.length)===U:X==="|="?Z===U||Z.substr(0,U.length+1)===U+"-":false},POS:function(X,U,V,Y){var T=U[2],W=I.setFilters[T];if(W){return W(X,V,U,Y)}}}};var M=I.match.POS;for(var O in I.match){I.match[O]=RegExp(I.match[O].source+/(?![^\[]*\])(?![^\(]*\))/.source)}var E=function(U,T){U=Array.prototype.slice.call(U);if(T){T.push.apply(T,U);return T}return U};try{Array.prototype.slice.call(document.documentElement.childNodes)}catch(N){E=function(X,W){var U=W||[];if(H.call(X)==="[object Array]"){Array.prototype.push.apply(U,X)}else{if(typeof X.length==="number"){for(var V=0,T=X.length;V<T;V++){U.push(X[V])}}else{for(var V=0;X[V];V++){U.push(X[V])}}}return U}}var G;if(document.documentElement.compareDocumentPosition){G=function(U,T){var V=U.compareDocumentPosition(T)&4?-1:U===T?0:1;if(V===0){hasDuplicate=true}return V}}else{if("sourceIndex" in document.documentElement){G=function(U,T){var V=U.sourceIndex-T.sourceIndex;if(V===0){hasDuplicate=true}return V}}else{if(document.createRange){G=function(W,U){var V=W.ownerDocument.createRange(),T=U.ownerDocument.createRange();V.selectNode(W);V.collapse(true);T.selectNode(U);T.collapse(true);var X=V.compareBoundaryPoints(Range.START_TO_END,T);if(X===0){hasDuplicate=true}return X}}}}(function(){var U=document.createElement("form"),V="script"+(new Date).getTime();U.innerHTML="<input name='"+V+"'/>";var T=document.documentElement;T.insertBefore(U,T.firstChild);if(!!document.getElementById(V)){I.find.ID=function(X,Y,Z){if(typeof Y.getElementById!=="undefined"&&!Z){var W=Y.getElementById(X[1]);return W?W.id===X[1]||typeof W.getAttributeNode!=="undefined"&&W.getAttributeNode("id").nodeValue===X[1]?[W]:g:[]}};I.filter.ID=function(Y,W){var X=typeof Y.getAttributeNode!=="undefined"&&Y.getAttributeNode("id");return Y.nodeType===1&&X&&X.nodeValue===W}}T.removeChild(U)})();(function(){var T=document.createElement("div");T.appendChild(document.createComment(""));if(T.getElementsByTagName("*").length>0){I.find.TAG=function(U,Y){var X=Y.getElementsByTagName(U[1]);if(U[1]==="*"){var W=[];for(var V=0;X[V];V++){if(X[V].nodeType===1){W.push(X[V])}}X=W}return X}}T.innerHTML="<a href='#'></a>";if(T.firstChild&&typeof T.firstChild.getAttribute!=="undefined"&&T.firstChild.getAttribute("href")!=="#"){I.attrHandle.href=function(U){return U.getAttribute("href",2)}}})();if(document.querySelectorAll){(function(){var T=F,U=document.createElement("div");U.innerHTML="<p class='TEST'></p>";if(U.querySelectorAll&&U.querySelectorAll(".TEST").length===0){return}F=function(Y,X,V,W){X=X||document;if(!W&&X.nodeType===9&&!Q(X)){try{return E(X.querySelectorAll(Y),V)}catch(Z){}}return T(Y,X,V,W)};F.find=T.find;F.filter=T.filter;F.selectors=T.selectors;F.matches=T.matches})()}if(document.getElementsByClassName&&document.documentElement.getElementsByClassName){(function(){var T=document.createElement("div");T.innerHTML="<div class='test e'></div><div class='test'></div>";if(T.getElementsByClassName("e").length===0){return}T.lastChild.className="e";if(T.getElementsByClassName("e").length===1){return}I.order.splice(1,0,"CLASS");I.find.CLASS=function(U,V,W){if(typeof V.getElementsByClassName!=="undefined"&&!W){return V.getElementsByClassName(U[1])}}})()}function P(U,Z,Y,ad,aa,ac){var ab=U=="previousSibling"&&!ac;for(var W=0,V=ad.length;W<V;W++){var T=ad[W];if(T){if(ab&&T.nodeType===1){T.sizcache=Y;T.sizset=W}T=T[U];var X=false;while(T){if(T.sizcache===Y){X=ad[T.sizset];break}if(T.nodeType===1&&!ac){T.sizcache=Y;T.sizset=W}if(T.nodeName===Z){X=T;break}T=T[U]}ad[W]=X}}}function S(U,Z,Y,ad,aa,ac){var ab=U=="previousSibling"&&!ac;for(var W=0,V=ad.length;W<V;W++){var T=ad[W];if(T){if(ab&&T.nodeType===1){T.sizcache=Y;T.sizset=W}T=T[U];var X=false;while(T){if(T.sizcache===Y){X=ad[T.sizset];break}if(T.nodeType===1){if(!ac){T.sizcache=Y;T.sizset=W}if(typeof Z!=="string"){if(T===Z){X=true;break}}else{if(F.filter(Z,[T]).length>0){X=T;break}}}T=T[U]}ad[W]=X}}}var K=document.compareDocumentPosition?function(U,T){return U.compareDocumentPosition(T)&16}:function(U,T){return U!==T&&(U.contains?U.contains(T):true)};var Q=function(T){return T.nodeType===9&&T.documentElement.nodeName!=="HTML"||!!T.ownerDocument&&Q(T.ownerDocument)};var J=function(T,aa){var W=[],X="",Y,V=aa.nodeType?[aa]:aa;while((Y=I.match.PSEUDO.exec(T))){X+=Y[0];T=T.replace(I.match.PSEUDO,"")}T=I.relative[T]?T+"*":T;for(var Z=0,U=V.length;Z<U;Z++){F(T,V[Z],W)}return F.filter(X,W)};o.find=F;o.filter=F.filter;o.expr=F.selectors;o.expr[":"]=o.expr.filters;F.selectors.filters.hidden=function(T){return T.offsetWidth===0||T.offsetHeight===0};F.selectors.filters.visible=function(T){return T.offsetWidth>0||T.offsetHeight>0};F.selectors.filters.animated=function(T){return o.grep(o.timers,function(U){return T===U.elem}).length};o.multiFilter=function(V,T,U){if(U){V=":not("+V+")"}return F.matches(V,T)};o.dir=function(V,U){var T=[],W=V[U];while(W&&W!=document){if(W.nodeType==1){T.push(W)}W=W[U]}return T};o.nth=function(X,T,V,W){T=T||1;var U=0;for(;X;X=X[V]){if(X.nodeType==1&&++U==T){break}}return X};o.sibling=function(V,U){var T=[];for(;V;V=V.nextSibling){if(V.nodeType==1&&V!=U){T.push(V)}}return T};return;l.Sizzle=F})();o.event={add:function(I,F,H,K){if(I.nodeType==3||I.nodeType==8){return}if(I.setInterval&&I!=l){I=l}if(!H.guid){H.guid=this.guid++}if(K!==g){var G=H;H=this.proxy(G);H.data=K}var E=o.data(I,"events")||o.data(I,"events",{}),J=o.data(I,"handle")||o.data(I,"handle",function(){return typeof o!=="undefined"&&!o.event.triggered?o.event.handle.apply(arguments.callee.elem,arguments):g});J.elem=I;o.each(F.split(/\s+/),function(M,N){var O=N.split(".");N=O.shift();H.type=O.slice().sort().join(".");var L=E[N];if(o.event.specialAll[N]){o.event.specialAll[N].setup.call(I,K,O)}if(!L){L=E[N]={};if(!o.event.special[N]||o.event.special[N].setup.call(I,K,O)===false){if(I.addEventListener){I.addEventListener(N,J,false)}else{if(I.attachEvent){I.attachEvent("on"+N,J)}}}}L[H.guid]=H;o.event.global[N]=true});I=null},guid:1,global:{},remove:function(K,H,J){if(K.nodeType==3||K.nodeType==8){return}var G=o.data(K,"events"),F,E;if(G){if(H===g||(typeof H==="string"&&H.charAt(0)==".")){for(var I in G){this.remove(K,I+(H||""))}}else{if(H.type){J=H.handler;H=H.type}o.each(H.split(/\s+/),function(M,O){var Q=O.split(".");O=Q.shift();var N=RegExp("(^|\\.)"+Q.slice().sort().join(".*\\.")+"(\\.|$)");if(G[O]){if(J){delete G[O][J.guid]}else{for(var P in G[O]){if(N.test(G[O][P].type)){delete G[O][P]}}}if(o.event.specialAll[O]){o.event.specialAll[O].teardown.call(K,Q)}for(F in G[O]){break}if(!F){if(!o.event.special[O]||o.event.special[O].teardown.call(K,Q)===false){if(K.removeEventListener){K.removeEventListener(O,o.data(K,"handle"),false)}else{if(K.detachEvent){K.detachEvent("on"+O,o.data(K,"handle"))}}}F=null;delete G[O]}}})}for(F in G){break}if(!F){var L=o.data(K,"handle");if(L){L.elem=null}o.removeData(K,"events");o.removeData(K,"handle")}}},trigger:function(I,K,H,E){var G=I.type||I;if(!E){I=typeof I==="object"?I[h]?I:o.extend(o.Event(G),I):o.Event(G);if(G.indexOf("!")>=0){I.type=G=G.slice(0,-1);I.exclusive=true}if(!H){I.stopPropagation();if(this.global[G]){o.each(o.cache,function(){if(this.events&&this.events[G]){o.event.trigger(I,K,this.handle.elem)}})}}if(!H||H.nodeType==3||H.nodeType==8){return g}I.result=g;I.target=H;K=o.makeArray(K);K.unshift(I)}I.currentTarget=H;var J=o.data(H,"handle");if(J){J.apply(H,K)}if((!H[G]||(o.nodeName(H,"a")&&G=="click"))&&H["on"+G]&&H["on"+G].apply(H,K)===false){I.result=false}if(!E&&H[G]&&!I.isDefaultPrevented()&&!(o.nodeName(H,"a")&&G=="click")){this.triggered=true;try{H[G]()}catch(L){}}this.triggered=false;if(!I.isPropagationStopped()){var F=H.parentNode||H.ownerDocument;if(F){o.event.trigger(I,K,F,true)}}},handle:function(K){var J,E;K=arguments[0]=o.event.fix(K||l.event);K.currentTarget=this;var L=K.type.split(".");K.type=L.shift();J=!L.length&&!K.exclusive;var I=RegExp("(^|\\.)"+L.slice().sort().join(".*\\.")+"(\\.|$)");E=(o.data(this,"events")||{})[K.type];for(var G in E){var H=E[G];if(J||I.test(H.type)){K.handler=H;K.data=H.data;var F=H.apply(this,arguments);if(F!==g){K.result=F;if(F===false){K.preventDefault();K.stopPropagation()}}if(K.isImmediatePropagationStopped()){break}}}},props:"altKey attrChange attrName bubbles button cancelable charCode clientX clientY ctrlKey currentTarget data detail eventPhase fromElement handler keyCode metaKey newValue originalTarget pageX pageY prevValue relatedNode relatedTarget screenX screenY shiftKey srcElement target toElement view wheelDelta which".split(" "),fix:function(H){if(H[h]){return H}var F=H;H=o.Event(F);for(var G=this.props.length,J;G;){J=this.props[--G];H[J]=F[J]}if(!H.target){H.target=H.srcElement||document}if(H.target.nodeType==3){H.target=H.target.parentNode}if(!H.relatedTarget&&H.fromElement){H.relatedTarget=H.fromElement==H.target?H.toElement:H.fromElement}if(H.pageX==null&&H.clientX!=null){var I=document.documentElement,E=document.body;H.pageX=H.clientX+(I&&I.scrollLeft||E&&E.scrollLeft||0)-(I.clientLeft||0);H.pageY=H.clientY+(I&&I.scrollTop||E&&E.scrollTop||0)-(I.clientTop||0)}if(!H.which&&((H.charCode||H.charCode===0)?H.charCode:H.keyCode)){H.which=H.charCode||H.keyCode}if(!H.metaKey&&H.ctrlKey){H.metaKey=H.ctrlKey}if(!H.which&&H.button){H.which=(H.button&1?1:(H.button&2?3:(H.button&4?2:0)))}return H},proxy:function(F,E){E=E||function(){return F.apply(this,arguments)};E.guid=F.guid=F.guid||E.guid||this.guid++;return E},special:{ready:{setup:B,teardown:function(){}}},specialAll:{live:{setup:function(E,F){o.event.add(this,F[0],c)},teardown:function(G){if(G.length){var E=0,F=RegExp("(^|\\.)"+G[0]+"(\\.|$)");o.each((o.data(this,"events").live||{}),function(){if(F.test(this.type)){E++}});if(E<1){o.event.remove(this,G[0],c)}}}}}};o.Event=function(E){if(!this.preventDefault){return new o.Event(E)}if(E&&E.type){this.originalEvent=E;this.type=E.type}else{this.type=E}this.timeStamp=e();this[h]=true};function k(){return false}function u(){return true}o.Event.prototype={preventDefault:function(){this.isDefaultPrevented=u;var E=this.originalEvent;if(!E){return}if(E.preventDefault){E.preventDefault()}E.returnValue=false},stopPropagation:function(){this.isPropagationStopped=u;var E=this.originalEvent;if(!E){return}if(E.stopPropagation){E.stopPropagation()}E.cancelBubble=true},stopImmediatePropagation:function(){this.isImmediatePropagationStopped=u;this.stopPropagation()},isDefaultPrevented:k,isPropagationStopped:k,isImmediatePropagationStopped:k};var a=function(F){var E=F.relatedTarget;while(E&&E!=this){try{E=E.parentNode}catch(G){E=this}}if(E!=this){F.type=F.data;o.event.handle.apply(this,arguments)}};o.each({mouseover:"mouseenter",mouseout:"mouseleave"},function(F,E){o.event.special[E]={setup:function(){o.event.add(this,F,a,E)},teardown:function(){o.event.remove(this,F,a)}}});o.fn.extend({bind:function(F,G,E){return F=="unload"?this.one(F,G,E):this.each(function(){o.event.add(this,F,E||G,E&&G)})},one:function(G,H,F){var E=o.event.proxy(F||H,function(I){o(this).unbind(I,E);return(F||H).apply(this,arguments)});return this.each(function(){o.event.add(this,G,E,F&&H)})},unbind:function(F,E){return this.each(function(){o.event.remove(this,F,E)})},trigger:function(E,F){return this.each(function(){o.event.trigger(E,F,this)})},triggerHandler:function(E,G){if(this[0]){var F=o.Event(E);F.preventDefault();F.stopPropagation();o.event.trigger(F,G,this[0]);return F.result}},toggle:function(G){var E=arguments,F=1;while(F<E.length){o.event.proxy(G,E[F++])}return this.click(o.event.proxy(G,function(H){this.lastToggle=(this.lastToggle||0)%F;H.preventDefault();return E[this.lastToggle++].apply(this,arguments)||false}))},hover:function(E,F){return this.mouseenter(E).mouseleave(F)},ready:function(E){B();if(o.isReady){E.call(document,o)}else{o.readyList.push(E)}return this},live:function(G,F){var E=o.event.proxy(F);E.guid+=this.selector+G;o(document).bind(i(G,this.selector),this.selector,E);return this},die:function(F,E){o(document).unbind(i(F,this.selector),E?{guid:E.guid+this.selector+F}:null);return this}});function c(H){var E=RegExp("(^|\\.)"+H.type+"(\\.|$)"),G=true,F=[];o.each(o.data(this,"events").live||[],function(I,J){if(E.test(J.type)){var K=o(H.target).closest(J.data)[0];if(K){F.push({elem:K,fn:J})}}});F.sort(function(J,I){return o.data(J.elem,"closest")-o.data(I.elem,"closest")});o.each(F,function(){if(this.fn.call(this.elem,H,this.fn.data)===false){return(G=false)}});return G}function i(F,E){return["live",F,E.replace(/\./g,"`").replace(/ /g,"|")].join(".")}o.extend({isReady:false,readyList:[],ready:function(){if(!o.isReady){o.isReady=true;if(o.readyList){o.each(o.readyList,function(){this.call(document,o)});o.readyList=null}o(document).triggerHandler("ready")}}});var x=false;function B(){if(x){return}x=true;if(document.addEventListener){document.addEventListener("DOMContentLoaded",function(){document.removeEventListener("DOMContentLoaded",arguments.callee,false);o.ready()},false)}else{if(document.attachEvent){document.attachEvent("onreadystatechange",function(){if(document.readyState==="complete"){document.detachEvent("onreadystatechange",arguments.callee);o.ready()}});if(document.documentElement.doScroll&&l==l.top){(function(){if(o.isReady){return}try{document.documentElement.doScroll("left")}catch(E){setTimeout(arguments.callee,0);return}o.ready()})()}}}o.event.add(l,"load",o.ready)}o.each(("blur,focus,load,resize,scroll,unload,click,dblclick,mousedown,mouseup,mousemove,mouseover,mouseout,mouseenter,mouseleave,change,select,submit,keydown,keypress,keyup,error").split(","),function(F,E){o.fn[E]=function(G){return G?this.bind(E,G):this.trigger(E)}});o(l).bind("unload",function(){for(var E in o.cache){if(E!=1&&o.cache[E].handle){o.event.remove(o.cache[E].handle.elem)}}});(function(){o.support={};var F=document.documentElement,G=document.createElement("script"),K=document.createElement("div"),J="script"+(new Date).getTime();K.style.display="none";K.innerHTML='   <link/><table></table><a href="/a" style="color:red;float:left;opacity:.5;">a</a><select><option>text</option></select><object><param/></object>';var H=K.getElementsByTagName("*"),E=K.getElementsByTagName("a")[0];if(!H||!H.length||!E){return}o.support={leadingWhitespace:K.firstChild.nodeType==3,tbody:!K.getElementsByTagName("tbody").length,objectAll:!!K.getElementsByTagName("object")[0].getElementsByTagName("*").length,htmlSerialize:!!K.getElementsByTagName("link").length,style:/red/.test(E.getAttribute("style")),hrefNormalized:E.getAttribute("href")==="/a",opacity:E.style.opacity==="0.5",cssFloat:!!E.style.cssFloat,scriptEval:false,noCloneEvent:true,boxModel:null};G.type="text/javascript";try{G.appendChild(document.createTextNode("window."+J+"=1;"))}catch(I){}F.insertBefore(G,F.firstChild);if(l[J]){o.support.scriptEval=true;delete l[J]}F.removeChild(G);if(K.attachEvent&&K.fireEvent){K.attachEvent("onclick",function(){o.support.noCloneEvent=false;K.detachEvent("onclick",arguments.callee)});K.cloneNode(true).fireEvent("onclick")}o(function(){var L=document.createElement("div");L.style.width=L.style.paddingLeft="1px";document.body.appendChild(L);o.boxModel=o.support.boxModel=L.offsetWidth===2;document.body.removeChild(L).style.display="none"})})();var w=o.support.cssFloat?"cssFloat":"styleFloat";o.props={"for":"htmlFor","class":"className","float":w,cssFloat:w,styleFloat:w,readonly:"readOnly",maxlength:"maxLength",cellspacing:"cellSpacing",rowspan:"rowSpan",tabindex:"tabIndex"};o.fn.extend({_load:o.fn.load,load:function(G,J,K){if(typeof G!=="string"){return this._load(G)}var I=G.indexOf(" ");if(I>=0){var E=G.slice(I,G.length);G=G.slice(0,I)}var H="GET";if(J){if(o.isFunction(J)){K=J;J=null}else{if(typeof J==="object"){J=o.param(J);H="POST"}}}var F=this;o.ajax({url:G,type:H,dataType:"html",data:J,complete:function(M,L){if(L=="success"||L=="notmodified"){F.html(E?o("<div/>").append(M.responseText.replace(/<script(.|\s)*?\/script>/g,"")).find(E):M.responseText)}if(K){F.each(K,[M.responseText,L,M])}}});return this},serialize:function(){return o.param(this.serializeArray())},serializeArray:function(){return this.map(function(){return this.elements?o.makeArray(this.elements):this}).filter(function(){return this.name&&!this.disabled&&(this.checked||/select|textarea/i.test(this.nodeName)||/text|hidden|password|search/i.test(this.type))}).map(function(E,F){var G=o(this).val();return G==null?null:o.isArray(G)?o.map(G,function(I,H){return{name:F.name,value:I}}):{name:F.name,value:G}}).get()}});o.each("ajaxStart,ajaxStop,ajaxComplete,ajaxError,ajaxSuccess,ajaxSend".split(","),function(E,F){o.fn[F]=function(G){return this.bind(F,G)}});var r=e();o.extend({get:function(E,G,H,F){if(o.isFunction(G)){H=G;G=null}return o.ajax({type:"GET",url:E,data:G,success:H,dataType:F})},getScript:function(E,F){return o.get(E,null,F,"script")},getJSON:function(E,F,G){return o.get(E,F,G,"json")},post:function(E,G,H,F){if(o.isFunction(G)){H=G;G={}}return o.ajax({type:"POST",url:E,data:G,success:H,dataType:F})},ajaxSetup:function(E){o.extend(o.ajaxSettings,E)},ajaxSettings:{url:location.href,global:true,type:"GET",contentType:"application/x-www-form-urlencoded",processData:true,async:true,xhr:function(){return l.ActiveXObject?new ActiveXObject("Microsoft.XMLHTTP"):new XMLHttpRequest()},accepts:{xml:"application/xml, text/xml",html:"text/html",script:"text/javascript, application/javascript",json:"application/json, text/javascript",text:"text/plain",_default:"*/*"}},lastModified:{},ajax:function(M){M=o.extend(true,M,o.extend(true,{},o.ajaxSettings,M));var W,F=/=\?(&|$)/g,R,V,G=M.type.toUpperCase();if(M.data&&M.processData&&typeof M.data!=="string"){M.data=o.param(M.data)}if(M.dataType=="jsonp"){if(G=="GET"){if(!M.url.match(F)){M.url+=(M.url.match(/\?/)?"&":"?")+(M.jsonp||"callback")+"=?"}}else{if(!M.data||!M.data.match(F)){M.data=(M.data?M.data+"&":"")+(M.jsonp||"callback")+"=?"}}M.dataType="json"}if(M.dataType=="json"&&(M.data&&M.data.match(F)||M.url.match(F))){W="jsonp"+r++;if(M.data){M.data=(M.data+"").replace(F,"="+W+"$1")}M.url=M.url.replace(F,"="+W+"$1");M.dataType="script";l[W]=function(X){V=X;I();L();l[W]=g;try{delete l[W]}catch(Y){}if(H){H.removeChild(T)}}}if(M.dataType=="script"&&M.cache==null){M.cache=false}if(M.cache===false&&G=="GET"){var E=e();var U=M.url.replace(/(\?|&)_=.*?(&|$)/,"$1_="+E+"$2");M.url=U+((U==M.url)?(M.url.match(/\?/)?"&":"?")+"_="+E:"")}if(M.data&&G=="GET"){M.url+=(M.url.match(/\?/)?"&":"?")+M.data;M.data=null}if(M.global&&!o.active++){o.event.trigger("ajaxStart")}var Q=/^(\w+:)?\/\/([^\/?#]+)/.exec(M.url);if(M.dataType=="script"&&G=="GET"&&Q&&(Q[1]&&Q[1]!=location.protocol||Q[2]!=location.host)){var H=document.getElementsByTagName("head")[0];var T=document.createElement("script");T.src=M.url;if(M.scriptCharset){T.charset=M.scriptCharset}if(!W){var O=false;T.onload=T.onreadystatechange=function(){if(!O&&(!this.readyState||this.readyState=="loaded"||this.readyState=="complete")){O=true;I();L();T.onload=T.onreadystatechange=null;H.removeChild(T)}}}H.appendChild(T);return g}var K=false;var J=M.xhr();if(M.username){J.open(G,M.url,M.async,M.username,M.password)}else{J.open(G,M.url,M.async)}try{if(M.data){J.setRequestHeader("Content-Type",M.contentType)}if(M.ifModified){J.setRequestHeader("If-Modified-Since",o.lastModified[M.url]||"Thu, 01 Jan 1970 00:00:00 GMT")}J.setRequestHeader("X-Requested-With","XMLHttpRequest");J.setRequestHeader("Accept",M.dataType&&M.accepts[M.dataType]?M.accepts[M.dataType]+", */*":M.accepts._default)}catch(S){}if(M.beforeSend&&M.beforeSend(J,M)===false){if(M.global&&!--o.active){o.event.trigger("ajaxStop")}J.abort();return false}if(M.global){o.event.trigger("ajaxSend",[J,M])}var N=function(X){if(J.readyState==0){if(P){clearInterval(P);P=null;if(M.global&&!--o.active){o.event.trigger("ajaxStop")}}}else{if(!K&&J&&(J.readyState==4||X=="timeout")){K=true;if(P){clearInterval(P);P=null}R=X=="timeout"?"timeout":!o.httpSuccess(J)?"error":M.ifModified&&o.httpNotModified(J,M.url)?"notmodified":"success";if(R=="success"){try{V=o.httpData(J,M.dataType,M)}catch(Z){R="parsererror"}}if(R=="success"){var Y;try{Y=J.getResponseHeader("Last-Modified")}catch(Z){}if(M.ifModified&&Y){o.lastModified[M.url]=Y}if(!W){I()}}else{o.handleError(M,J,R)}L();if(X){J.abort()}if(M.async){J=null}}}};if(M.async){var P=setInterval(N,13);if(M.timeout>0){setTimeout(function(){if(J&&!K){N("timeout")}},M.timeout)}}try{J.send(M.data)}catch(S){o.handleError(M,J,null,S)}if(!M.async){N()}function I(){if(M.success){M.success(V,R)}if(M.global){o.event.trigger("ajaxSuccess",[J,M])}}function L(){if(M.complete){M.complete(J,R)}if(M.global){o.event.trigger("ajaxComplete",[J,M])}if(M.global&&!--o.active){o.event.trigger("ajaxStop")}}return J},handleError:function(F,H,E,G){if(F.error){F.error(H,E,G)}if(F.global){o.event.trigger("ajaxError",[H,F,G])}},active:0,httpSuccess:function(F){try{return !F.status&&location.protocol=="file:"||(F.status>=200&&F.status<300)||F.status==304||F.status==1223}catch(E){}return false},httpNotModified:function(G,E){try{var H=G.getResponseHeader("Last-Modified");return G.status==304||H==o.lastModified[E]}catch(F){}return false},httpData:function(J,H,G){var F=J.getResponseHeader("content-type"),E=H=="xml"||!H&&F&&F.indexOf("xml")>=0,I=E?J.responseXML:J.responseText;if(E&&I.documentElement.tagName=="parsererror"){throw"parsererror"}if(G&&G.dataFilter){I=G.dataFilter(I,H)}if(typeof I==="string"){if(H=="script"){o.globalEval(I)}if(H=="json"){I=l["eval"]("("+I+")")}}return I},param:function(E){var G=[];function H(I,J){G[G.length]=encodeURIComponent(I)+"="+encodeURIComponent(J)}if(o.isArray(E)||E.jquery){o.each(E,function(){H(this.name,this.value)})}else{for(var F in E){if(o.isArray(E[F])){o.each(E[F],function(){H(F,this)})}else{H(F,o.isFunction(E[F])?E[F]():E[F])}}}return G.join("&").replace(/%20/g,"+")}});var m={},n,d=[["height","marginTop","marginBottom","paddingTop","paddingBottom"],["width","marginLeft","marginRight","paddingLeft","paddingRight"],["opacity"]];function t(F,E){var G={};o.each(d.concat.apply([],d.slice(0,E)),function(){G[this]=F});return G}o.fn.extend({show:function(J,L){if(J){return this.animate(t("show",3),J,L)}else{for(var H=0,F=this.length;H<F;H++){var E=o.data(this[H],"olddisplay");this[H].style.display=E||"";if(o.css(this[H],"display")==="none"){var G=this[H].tagName,K;if(m[G]){K=m[G]}else{var I=o("<"+G+" />").appendTo("body");K=I.css("display");if(K==="none"){K="block"}I.remove();m[G]=K}o.data(this[H],"olddisplay",K)}}for(var H=0,F=this.length;H<F;H++){this[H].style.display=o.data(this[H],"olddisplay")||""}return this}},hide:function(H,I){if(H){return this.animate(t("hide",3),H,I)}else{for(var G=0,F=this.length;G<F;G++){var E=o.data(this[G],"olddisplay");if(!E&&E!=="none"){o.data(this[G],"olddisplay",o.css(this[G],"display"))}}for(var G=0,F=this.length;G<F;G++){this[G].style.display="none"}return this}},_toggle:o.fn.toggle,toggle:function(G,F){var E=typeof G==="boolean";return o.isFunction(G)&&o.isFunction(F)?this._toggle.apply(this,arguments):G==null||E?this.each(function(){var H=E?G:o(this).is(":hidden");o(this)[H?"show":"hide"]()}):this.animate(t("toggle",3),G,F)},fadeTo:function(E,G,F){return this.animate({opacity:G},E,F)},animate:function(I,F,H,G){var E=o.speed(F,H,G);return this[E.queue===false?"each":"queue"](function(){var K=o.extend({},E),M,L=this.nodeType==1&&o(this).is(":hidden"),J=this;for(M in I){if(I[M]=="hide"&&L||I[M]=="show"&&!L){return K.complete.call(this)}if((M=="height"||M=="width")&&this.style){K.display=o.css(this,"display");K.overflow=this.style.overflow}}if(K.overflow!=null){this.style.overflow="hidden"}K.curAnim=o.extend({},I);o.each(I,function(O,S){var R=new o.fx(J,K,O);if(/toggle|show|hide/.test(S)){R[S=="toggle"?L?"show":"hide":S](I)}else{var Q=S.toString().match(/^([+-]=)?([\d+-.]+)(.*)$/),T=R.cur(true)||0;if(Q){var N=parseFloat(Q[2]),P=Q[3]||"px";if(P!="px"){J.style[O]=(N||1)+P;T=((N||1)/R.cur(true))*T;J.style[O]=T+P}if(Q[1]){N=((Q[1]=="-="?-1:1)*N)+T}R.custom(T,N,P)}else{R.custom(T,S,"")}}});return true})},stop:function(F,E){var G=o.timers;if(F){this.queue([])}this.each(function(){for(var H=G.length-1;H>=0;H--){if(G[H].elem==this){if(E){G[H](true)}G.splice(H,1)}}});if(!E){this.dequeue()}return this}});o.each({slideDown:t("show",1),slideUp:t("hide",1),slideToggle:t("toggle",1),fadeIn:{opacity:"show"},fadeOut:{opacity:"hide"}},function(E,F){o.fn[E]=function(G,H){return this.animate(F,G,H)}});o.extend({speed:function(G,H,F){var E=typeof G==="object"?G:{complete:F||!F&&H||o.isFunction(G)&&G,duration:G,easing:F&&H||H&&!o.isFunction(H)&&H};E.duration=o.fx.off?0:typeof E.duration==="number"?E.duration:o.fx.speeds[E.duration]||o.fx.speeds._default;E.old=E.complete;E.complete=function(){if(E.queue!==false){o(this).dequeue()}if(o.isFunction(E.old)){E.old.call(this)}};return E},easing:{linear:function(G,H,E,F){return E+F*G},swing:function(G,H,E,F){return((-Math.cos(G*Math.PI)/2)+0.5)*F+E}},timers:[],fx:function(F,E,G){this.options=E;this.elem=F;this.prop=G;if(!E.orig){E.orig={}}}});o.fx.prototype={update:function(){if(this.options.step){this.options.step.call(this.elem,this.now,this)}(o.fx.step[this.prop]||o.fx.step._default)(this);if((this.prop=="height"||this.prop=="width")&&this.elem.style){this.elem.style.display="block"}},cur:function(F){if(this.elem[this.prop]!=null&&(!this.elem.style||this.elem.style[this.prop]==null)){return this.elem[this.prop]}var E=parseFloat(o.css(this.elem,this.prop,F));return E&&E>-10000?E:parseFloat(o.curCSS(this.elem,this.prop))||0},custom:function(I,H,G){this.startTime=e();this.start=I;this.end=H;this.unit=G||this.unit||"px";this.now=this.start;this.pos=this.state=0;var E=this;function F(J){return E.step(J)}F.elem=this.elem;if(F()&&o.timers.push(F)&&!n){n=setInterval(function(){var K=o.timers;for(var J=0;J<K.length;J++){if(!K[J]()){K.splice(J--,1)}}if(!K.length){clearInterval(n);n=g}},13)}},show:function(){this.options.orig[this.prop]=o.attr(this.elem.style,this.prop);this.options.show=true;this.custom(this.prop=="width"||this.prop=="height"?1:0,this.cur());o(this.elem).show()},hide:function(){this.options.orig[this.prop]=o.attr(this.elem.style,this.prop);this.options.hide=true;this.custom(this.cur(),0)},step:function(H){var G=e();if(H||G>=this.options.duration+this.startTime){this.now=this.end;this.pos=this.state=1;this.update();this.options.curAnim[this.prop]=true;var E=true;for(var F in this.options.curAnim){if(this.options.curAnim[F]!==true){E=false}}if(E){if(this.options.display!=null){this.elem.style.overflow=this.options.overflow;this.elem.style.display=this.options.display;if(o.css(this.elem,"display")=="none"){this.elem.style.display="block"}}if(this.options.hide){o(this.elem).hide()}if(this.options.hide||this.options.show){for(var I in this.options.curAnim){o.attr(this.elem.style,I,this.options.orig[I])}}this.options.complete.call(this.elem)}return false}else{var J=G-this.startTime;this.state=J/this.options.duration;this.pos=o.easing[this.options.easing||(o.easing.swing?"swing":"linear")](this.state,J,0,1,this.options.duration);this.now=this.start+((this.end-this.start)*this.pos);this.update()}return true}};o.extend(o.fx,{speeds:{slow:600,fast:200,_default:400},step:{opacity:function(E){o.attr(E.elem.style,"opacity",E.now)},_default:function(E){if(E.elem.style&&E.elem.style[E.prop]!=null){E.elem.style[E.prop]=E.now+E.unit}else{E.elem[E.prop]=E.now}}}});if(document.documentElement.getBoundingClientRect){o.fn.offset=function(){if(!this[0]){return{top:0,left:0}}if(this[0]===this[0].ownerDocument.body){return o.offset.bodyOffset(this[0])}var G=this[0].getBoundingClientRect(),J=this[0].ownerDocument,F=J.body,E=J.documentElement,L=E.clientTop||F.clientTop||0,K=E.clientLeft||F.clientLeft||0,I=G.top+(self.pageYOffset||o.boxModel&&E.scrollTop||F.scrollTop)-L,H=G.left+(self.pageXOffset||o.boxModel&&E.scrollLeft||F.scrollLeft)-K;return{top:I,left:H}}}else{o.fn.offset=function(){if(!this[0]){return{top:0,left:0}}if(this[0]===this[0].ownerDocument.body){return o.offset.bodyOffset(this[0])}o.offset.initialized||o.offset.initialize();var J=this[0],G=J.offsetParent,F=J,O=J.ownerDocument,M,H=O.documentElement,K=O.body,L=O.defaultView,E=L.getComputedStyle(J,null),N=J.offsetTop,I=J.offsetLeft;while((J=J.parentNode)&&J!==K&&J!==H){M=L.getComputedStyle(J,null);N-=J.scrollTop,I-=J.scrollLeft;if(J===G){N+=J.offsetTop,I+=J.offsetLeft;if(o.offset.doesNotAddBorder&&!(o.offset.doesAddBorderForTableAndCells&&/^t(able|d|h)$/i.test(J.tagName))){N+=parseInt(M.borderTopWidth,10)||0,I+=parseInt(M.borderLeftWidth,10)||0}F=G,G=J.offsetParent}if(o.offset.subtractsBorderForOverflowNotVisible&&M.overflow!=="visible"){N+=parseInt(M.borderTopWidth,10)||0,I+=parseInt(M.borderLeftWidth,10)||0}E=M}if(E.position==="relative"||E.position==="static"){N+=K.offsetTop,I+=K.offsetLeft}if(E.position==="fixed"){N+=Math.max(H.scrollTop,K.scrollTop),I+=Math.max(H.scrollLeft,K.scrollLeft)}return{top:N,left:I}}}o.offset={initialize:function(){if(this.initialized){return}var L=document.body,F=document.createElement("div"),H,G,N,I,M,E,J=L.style.marginTop,K='<div style="position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;"><div></div></div><table style="position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;" cellpadding="0" cellspacing="0"><tr><td></td></tr></table>';M={position:"absolute",top:0,left:0,margin:0,border:0,width:"1px",height:"1px",visibility:"hidden"};for(E in M){F.style[E]=M[E]}F.innerHTML=K;L.insertBefore(F,L.firstChild);H=F.firstChild,G=H.firstChild,I=H.nextSibling.firstChild.firstChild;this.doesNotAddBorder=(G.offsetTop!==5);this.doesAddBorderForTableAndCells=(I.offsetTop===5);H.style.overflow="hidden",H.style.position="relative";this.subtractsBorderForOverflowNotVisible=(G.offsetTop===-5);L.style.marginTop="1px";this.doesNotIncludeMarginInBodyOffset=(L.offsetTop===0);L.style.marginTop=J;L.removeChild(F);this.initialized=true},bodyOffset:function(E){o.offset.initialized||o.offset.initialize();var G=E.offsetTop,F=E.offsetLeft;if(o.offset.doesNotIncludeMarginInBodyOffset){G+=parseInt(o.curCSS(E,"marginTop",true),10)||0,F+=parseInt(o.curCSS(E,"marginLeft",true),10)||0}return{top:G,left:F}}};o.fn.extend({position:function(){var I=0,H=0,F;if(this[0]){var G=this.offsetParent(),J=this.offset(),E=/^body|html$/i.test(G[0].tagName)?{top:0,left:0}:G.offset();J.top-=j(this,"marginTop");J.left-=j(this,"marginLeft");E.top+=j(G,"borderTopWidth");E.left+=j(G,"borderLeftWidth");F={top:J.top-E.top,left:J.left-E.left}}return F},offsetParent:function(){var E=this[0].offsetParent||document.body;while(E&&(!/^body|html$/i.test(E.tagName)&&o.css(E,"position")=="static")){E=E.offsetParent}return o(E)}});o.each(["Left","Top"],function(F,E){var G="scroll"+E;o.fn[G]=function(H){if(!this[0]){return null}return H!==g?this.each(function(){this==l||this==document?l.scrollTo(!F?H:o(l).scrollLeft(),F?H:o(l).scrollTop()):this[G]=H}):this[0]==l||this[0]==document?self[F?"pageYOffset":"pageXOffset"]||o.boxModel&&document.documentElement[G]||document.body[G]:this[0][G]}});o.each(["Height","Width"],function(I,G){var E=I?"Left":"Top",H=I?"Right":"Bottom",F=G.toLowerCase();o.fn["inner"+G]=function(){return this[0]?o.css(this[0],F,false,"padding"):null};o.fn["outer"+G]=function(K){return this[0]?o.css(this[0],F,false,K?"margin":"border"):null};var J=G.toLowerCase();o.fn[J]=function(K){return this[0]==l?document.compatMode=="CSS1Compat"&&document.documentElement["client"+G]||document.body["client"+G]:this[0]==document?Math.max(document.documentElement["client"+G],document.body["scroll"+G],document.documentElement["scroll"+G],document.body["offset"+G],document.documentElement["offset"+G]):K===g?(this.length?o.css(this[0],J):null):this.css(J,typeof K==="string"?K:K+"px")}})})();
// file seperator

/**
 * Cookie plugin
 *
 * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 */

/**
 * Create a cookie with the given name and value and other optional parameters.
 *
 * @example $.cookie('the_cookie', 'the_value');
 * @desc Set the value of a cookie.
 * @example $.cookie('the_cookie', 'the_value', {expires: 7, path: '/', domain: 'jquery.com', secure: true});
 * @desc Create a cookie with all available options.
 * @example $.cookie('the_cookie', 'the_value');
 * @desc Create a session cookie.
 * @example $.cookie('the_cookie', '', {expires: -1});
 * @desc Delete a cookie by setting a date in the past.
 *
 * @param String name The name of the cookie.
 * @param String value The value of the cookie.
 * @param Object options An object literal containing key/value pairs to provide optional cookie attributes.
 * @option Number|Date expires Either an integer specifying the expiration date from now on in days or a Date object.
 *                             If a negative value is specified (e.g. a date in the past), the cookie will be deleted.
 *                             If set to null or omitted, the cookie will be a session cookie and will not be retained
 *                             when the the browser exits.
 * @option String path The value of the path atribute of the cookie (default: path of page that created the cookie).
 * @option String domain The value of the domain attribute of the cookie (default: domain of page that created the cookie).
 * @option Boolean secure If true, the secure attribute of the cookie will be set and the cookie transmission will
 *                        require a secure protocol (like HTTPS).
 * @type undefined
 *
 * @name $.cookie
 * @cat Plugins/Cookie
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */

/**
 * Get the value of a cookie with the given name.
 *
 * @example $.cookie('the_cookie');
 * @desc Get the value of a cookie.
 *
 * @param String name The name of the cookie.
 * @return The value of the cookie.
 * @type String
 *
 * @name $.cookie
 * @cat Plugins/Cookie
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toGMTString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toGMTString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};
// file seperator

/**
* hoverIntent is similar to jQuery's built-in "hover" function except that
* instead of firing the onMouseOver event immediately, hoverIntent checks
* to see if the user's mouse has slowed down (beneath the sensitivity
* threshold) before firing the onMouseOver event.
* 
* hoverIntent r5 // 2007.03.27 // jQuery 1.1.2
* <http://cherne.net/brian/resources/jquery.hoverIntent.html>
* 
* hoverIntent is currently available for use in all personal or commercial 
* projects under both MIT and GPL licenses. This means that you can choose 
* the license that best suits your project, and use it accordingly.
* 
* // basic usage (just like .hover) receives onMouseOver and onMouseOut functions
* $("ul li").hoverIntent( showNav , hideNav );
* 
* // advanced usage receives configuration object only
* $("ul li").hoverIntent({
*	sensitivity: 2, // number = sensitivity threshold (must be 1 or higher)
*	interval: 50,   // number = milliseconds of polling interval
*	over: showNav,  // function = onMouseOver callback (required)
*	timeout: 100,   // number = milliseconds delay before onMouseOut function call
*	out: hideNav    // function = onMouseOut callback (required)
* });
* 
* @param  f  onMouseOver function || An object with configuration options
* @param  g  onMouseOut function  || Nothing (use configuration options object)
* @return    The object (aka "this") that called hoverIntent, and the event object
* @author    Brian Cherne <brian@cherne.net>
*/
(function($) {
	$.fn.hoverIntent = function(f,g) {
		// default configuration options
		var cfg = {
			sensitivity: 7,
			interval: 100,
			timeout: 0
		};
		// override configuration options with user supplied object
		cfg = $.extend(cfg, g ? { over: f, out: g } : f );

		// instantiate variables
		// cX, cY = current X and Y position of mouse, updated by mousemove event
		// pX, pY = previous X and Y position of mouse, set by mouseover and polling interval
		var cX, cY, pX, pY;

		// A private function for getting mouse position
		var track = function(ev) {
			cX = ev.pageX;
			cY = ev.pageY;
		};

		// A private function for comparing current and previous mouse position
		var compare = function(ev,ob) {
			ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t);
			// compare mouse positions to see if they've crossed the threshold
			if ( ( Math.abs(pX-cX) + Math.abs(pY-cY) ) < cfg.sensitivity ) {
				$(ob).unbind("mousemove",track);
				// set hoverIntent state to true (so mouseOut can be called)
				ob.hoverIntent_s = 1;
				return cfg.over.apply(ob,[ev]);
			} else {
				// set previous coordinates for next time
				pX = cX; pY = cY;
				// use self-calling timeout, guarantees intervals are spaced out properly (avoids JavaScript timer bugs)
				ob.hoverIntent_t = setTimeout( function(){compare(ev, ob);} , cfg.interval );
			}
		};

		// A private function for delaying the mouseOut function
		var delay = function(ev,ob) {
			ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t);
			ob.hoverIntent_s = 0;
			return cfg.out.apply(ob,[ev]);
		};

		// A private function for handling mouse 'hovering'
		var handleHover = function(e) {
			// next three lines copied from jQuery.hover, ignore children onMouseOver/onMouseOut
			var p = (e.type == "mouseover" ? e.fromElement : e.toElement) || e.relatedTarget;
			while ( p && p != this ) { try { p = p.parentNode; } catch(e) { p = this; } }
			if ( p == this ) { return false; }

			// copy objects to be passed into t (required for event object to be passed in IE)
			var ev = jQuery.extend({},e);
			var ob = this;

			// cancel hoverIntent timer if it exists
			if (ob.hoverIntent_t) { ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t); }

			// else e.type == "onmouseover"
			if (e.type == "mouseover") {
				// set "previous" X and Y position based on initial entry point
				pX = ev.pageX; pY = ev.pageY;
				// update "current" X and Y position based on mousemove
				$(ob).bind("mousemove",track);
				// start polling interval (self-calling timeout) to compare mouse coordinates over time
				if (ob.hoverIntent_s != 1) { ob.hoverIntent_t = setTimeout( function(){compare(ev,ob);} , cfg.interval );}

			// else e.type == "onmouseout"
			} else {
				// unbind expensive mousemove event
				$(ob).unbind("mousemove",track);
				// if hoverIntent state is true, then call the mouseOut function after the specified delay
				if (ob.hoverIntent_s == 1) { ob.hoverIntent_t = setTimeout( function(){delay(ev,ob);} , cfg.timeout );}
			}
		};

		// bind the function to the two event listeners
		return this.mouseover(handleHover).mouseout(handleHover);
	};
})(jQuery);
// file seperator

/* Copyright (c) 2007 Paul Bakaus (paul.bakaus@googlemail.com) and Brandon Aaron (brandon.aaron@gmail.com || http://brandonaaron.net)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * $LastChangedDate: 2007-08-12 22:47:23 -0500 (Sun, 12 Aug 2007) $
 * $Rev: 2669 $
 *
 * Version: 1.1
 *
 * Requires: jQuery 1.1.3+
 */

(function($){

// store a copy of the core height and width methods
var height = $.fn.height,
    width  = $.fn.width;

$.fn.extend({
	/**
	 * If used on document, returns the document's height (innerHeight).
	 * If used on window, returns the viewport's (window) height.
	 * See core docs on height() to see what happens when used on an element.
	 *
	 * @example $("#testdiv").height()
	 * @result 200
	 *
	 * @example $(document).height()
	 * @result 800
	 *
	 * @example $(window).height()
	 * @result 400
	 *
	 * @name height
	 * @type Number
	 * @cat Plugins/Dimensions
	 */
	height: function() {
		if (!this[0]) error();
		if ( this[0] == window )
			if ( ($.browser.mozilla || $.browser.opera) && $(document).width() > self.innerWidth)
				// mozilla and opera both return width + scrollbar width
				return self.innerHeight - getScrollbarWidth();
			else
				return self.innerHeight ||
					$.boxModel && document.documentElement.clientHeight || 
					document.body.clientHeight;
		
		if ( this[0] == document )
			return Math.max( document.body.scrollHeight, document.body.offsetHeight );
		
		return height.apply(this, arguments);
	},
	
	/**
	 * If used on document, returns the document's width (innerWidth).
	 * If used on window, returns the viewport's (window) width.
	 * See core docs on width() to see what happens when used on an element.
	 *
	 * @example $("#testdiv").width()
	 * @result 200
	 *
	 * @example $(document).width()
	 * @result 800
	 *
	 * @example $(window).width()
	 * @result 400
	 *
	 * @name width
	 * @type Number
	 * @cat Plugins/Dimensions
	 */
	width: function() {
		if (!this[0]) error();
		if ( this[0] == window )
			if (($.browser.mozilla || $.browser.opera) && $(document).height() > self.innerHeight)
				// mozilla and opera both return width + scrollbar width
				return self.innerWidth - getScrollbarWidth();
			else
				return self.innerWidth ||
					$.boxModel && document.documentElement.clientWidth ||
					document.body.clientWidth;

		if ( this[0] == document )
			if ($.browser.mozilla) {
				// mozilla reports scrollWidth and offsetWidth as the same
				var scrollLeft = self.pageXOffset;
				self.scrollTo(99999999, self.pageYOffset);
				var scrollWidth = self.pageXOffset;
				self.scrollTo(scrollLeft, self.pageYOffset);
				return document.body.offsetWidth + scrollWidth;
			}
			else 
				return Math.max( document.body.scrollWidth, document.body.offsetWidth );

		return width.apply(this, arguments);
	},
	
	/**
	 * Gets the inner height (excludes the border and includes the padding) for the first matched element.
	 * If used on document, returns the document's height (innerHeight).
	 * If used on window, returns the viewport's (window) height.
	 *
	 * @example $("#testdiv").innerHeight()
	 * @result 210
	 *
	 * @name innerHeight
	 * @type Number
	 * @cat Plugins/Dimensions
	 */
	innerHeight: function() {
		if (!this[0]) error();
		return this[0] == window || this[0] == document ?
			this.height() :
			this.is(':visible') ?
				this[0].offsetHeight - num(this, 'borderTopWidth') - num(this, 'borderBottomWidth') :
				this.height() + num(this, 'paddingTop') + num(this, 'paddingBottom');
	},
	
	/**
	 * Gets the inner width (excludes the border and includes the padding) for the first matched element.
	 * If used on document, returns the document's width (innerWidth).
	 * If used on window, returns the viewport's (window) width.
	 *
	 * @example $("#testdiv").innerWidth()
	 * @result 210
	 *
	 * @name innerWidth
	 * @type Number
	 * @cat Plugins/Dimensions
	 */
	innerWidth: function() {
		if (!this[0]) error();
		return this[0] == window || this[0] == document ?
			this.width() :
			this.is(':visible') ?
				this[0].offsetWidth - num(this, 'borderLeftWidth') - num(this, 'borderRightWidth') :
				this.width() + num(this, 'paddingLeft') + num(this, 'paddingRight');
	},
	
	/**
	 * Gets the outer height (includes the border and padding) for the first matched element.
	 * If used on document, returns the document's height (innerHeight).
	 * If used on window, returns the viewport's (window) height.
	 *
	 * The margin can be included in the calculation by passing an options map with margin
	 * set to true.
	 *
	 * @example $("#testdiv").outerHeight()
	 * @result 220
	 *
	 * @example $("#testdiv").outerHeight({ margin: true })
	 * @result 240
	 *
	 * @name outerHeight
	 * @type Number
	 * @param Map options Optional settings to configure the way the outer height is calculated.
	 * @cat Plugins/Dimensions
	 */
	outerHeight: function(options) {
		if (!this[0]) error();
		options = $.extend({ margin: false }, options || {});
		return this[0] == window || this[0] == document ?
			this.height() :
			this.is(':visible') ?
				this[0].offsetHeight + (options.margin ? (num(this, 'marginTop') + num(this, 'marginBottom')) : 0) :
				this.height() 
					+ num(this,'borderTopWidth') + num(this, 'borderBottomWidth') 
					+ num(this, 'paddingTop') + num(this, 'paddingBottom')
					+ (options.margin ? (num(this, 'marginTop') + num(this, 'marginBottom')) : 0);
	},
	
	/**
	 * Gets the outer width (including the border and padding) for the first matched element.
	 * If used on document, returns the document's width (innerWidth).
	 * If used on window, returns the viewport's (window) width.
	 *
	 * The margin can be included in the calculation by passing an options map with margin
	 * set to true.
	 *
	 * @example $("#testdiv").outerWidth()
	 * @result 1000
	 *
	 * @example $("#testdiv").outerWidth({ margin: true })
	 * @result 1020
	 * 
	 * @name outerHeight
	 * @type Number
	 * @param Map options Optional settings to configure the way the outer width is calculated.
	 * @cat Plugins/Dimensions
	 */
	outerWidth: function(options) {
		if (!this[0]) error();
		options = $.extend({ margin: false }, options || {});
		return this[0] == window || this[0] == document ?
			this.width() :
			this.is(':visible') ?
				this[0].offsetWidth + (options.margin ? (num(this, 'marginLeft') + num(this, 'marginRight')) : 0) :
				this.width() 
					+ num(this, 'borderLeftWidth') + num(this, 'borderRightWidth') 
					+ num(this, 'paddingLeft') + num(this, 'paddingRight')
					+ (options.margin ? (num(this, 'marginLeft') + num(this, 'marginRight')) : 0);
	},
	
	/**
	 * Gets how many pixels the user has scrolled to the right (scrollLeft).
	 * Works on containers with overflow: auto and window/document.
	 *
	 * @example $(window).scrollLeft()
	 * @result 100
	 *
	 * @example $(document).scrollLeft()
	 * @result 100
	 * 
	 * @example $("#testdiv").scrollLeft()
	 * @result 100
	 *
	 * @name scrollLeft
	 * @type Number
	 * @cat Plugins/Dimensions
	 */
	/**
	 * Sets the scrollLeft property for each element and continues the chain.
	 * Works on containers with overflow: auto and window/document.
	 *
	 * @example $(window).scrollLeft(100).scrollLeft()
	 * @result 100
	 * 
	 * @example $(document).scrollLeft(100).scrollLeft()
	 * @result 100
	 *
	 * @example $("#testdiv").scrollLeft(100).scrollLeft()
	 * @result 100
	 *
	 * @name scrollLeft
	 * @param Number value A positive number representing the desired scrollLeft.
	 * @type jQuery
	 * @cat Plugins/Dimensions
	 */
	scrollLeft: function(val) {
		if (!this[0]) error();
		if ( val != undefined )
			// set the scroll left
			return this.each(function() {
				if (this == window || this == document)
					window.scrollTo( val, $(window).scrollTop() );
				else
					this.scrollLeft = val;
			});
		
		// return the scroll left offest in pixels
		if ( this[0] == window || this[0] == document )
			return self.pageXOffset ||
				$.boxModel && document.documentElement.scrollLeft ||
				document.body.scrollLeft;
				
		return this[0].scrollLeft;
	},
	
	/**
	 * Gets how many pixels the user has scrolled to the bottom (scrollTop).
	 * Works on containers with overflow: auto and window/document.
	 *
	 * @example $(window).scrollTop()
	 * @result 100
	 *
	 * @example $(document).scrollTop()
	 * @result 100
	 * 
	 * @example $("#testdiv").scrollTop()
	 * @result 100
	 *
	 * @name scrollTop
	 * @type Number
	 * @cat Plugins/Dimensions
	 */
	/**
	 * Sets the scrollTop property for each element and continues the chain.
	 * Works on containers with overflow: auto and window/document.
	 *
	 * @example $(window).scrollTop(100).scrollTop()
	 * @result 100
	 * 
	 * @example $(document).scrollTop(100).scrollTop()
	 * @result 100
	 *
	 * @example $("#testdiv").scrollTop(100).scrollTop()
	 * @result 100
	 *
	 * @name scrollTop
	 * @param Number value A positive number representing the desired scrollTop.
	 * @type jQuery
	 * @cat Plugins/Dimensions
	 */
	scrollTop: function(val) {
		if (!this[0]) error();
		if ( val != undefined )
			// set the scroll top
			return this.each(function() {
				if (this == window || this == document)
					window.scrollTo( $(window).scrollLeft(), val );
				else
					this.scrollTop = val;
			});
		
		// return the scroll top offset in pixels
		if ( this[0] == window || this[0] == document )
			return self.pageYOffset ||
				$.boxModel && document.documentElement.scrollTop ||
				document.body.scrollTop;

		return this[0].scrollTop;
	},
	
	/** 
	 * Gets the top and left positioned offset in pixels.
	 * The positioned offset is the offset between a positioned
	 * parent and the element itself.
	 *
	 * For accurate calculations make sure to use pixel values for margins, borders and padding.
	 *
	 * @example $("#testdiv").position()
	 * @result { top: 100, left: 100 }
	 *
	 * @example var position = {};
	 * $("#testdiv").position(position)
	 * @result position = { top: 100, left: 100 }
	 * 
	 * @name position
	 * @param Object returnObject Optional An object to store the return value in, so as not to break the chain. If passed in the
	 *                            chain will not be broken and the result will be assigned to this object.
	 * @type Object
	 * @cat Plugins/Dimensions
	 */
	position: function(returnObject) {
		return this.offset({ margin: false, scroll: false, relativeTo: this.offsetParent() }, returnObject);
	},
	
	/**
	 * Gets the location of the element in pixels from the top left corner of the viewport.
	 * The offset method takes an optional map of key value pairs to configure the way
	 * the offset is calculated. Here are the different options.
	 *
	 * (Boolean) margin - Should the margin of the element be included in the calculations? True by default.
	 * (Boolean) border - Should the border of the element be included in the calculations? False by default. 
	 * (Boolean) padding - Should the padding of the element be included in the calculations? False by default. 
	 * (Boolean) scroll - Should the scroll offsets of the parent elements be included in the calculations? True by default.
	 *                    When true it adds the total scroll offsets of all parents to the total offset and also adds two
	 *                    properties to the returned object, scrollTop and scrollLeft.
	 * (Boolean) lite - When true it will use the offsetLite method instead of the full-blown, slower offset method. False by default.
	 *                  Only use this when margins, borders and padding calculations don't matter.
	 * (HTML Element) relativeTo - This should be a parent of the element and should have position (like absolute or relative).
	 *                             It will retreive the offset relative to this parent element. By default it is the body element.
	 *
	 * Also an object can be passed as the second paramater to
	 * catch the value of the return and continue the chain.
	 *
	 * For accurate calculations make sure to use pixel values for margins, borders and padding.
	 * 
	 * Known issues:
	 *  - Issue: A div positioned relative or static without any content before it and its parent will report an offsetTop of 0 in Safari
	 *    Workaround: Place content before the relative div ... and set height and width to 0 and overflow to hidden
	 *
	 * @example $("#testdiv").offset()
	 * @result { top: 100, left: 100, scrollTop: 10, scrollLeft: 10 }
	 *
	 * @example $("#testdiv").offset({ scroll: false })
	 * @result { top: 90, left: 90 }
	 *
	 * @example var offset = {}
	 * $("#testdiv").offset({ scroll: false }, offset)
	 * @result offset = { top: 90, left: 90 }
	 *
	 * @name offset
	 * @param Map options Optional settings to configure the way the offset is calculated.
	 * @param Object returnObject An object to store the return value in, so as not to break the chain. If passed in the
	 *                            chain will not be broken and the result will be assigned to this object.
	 * @type Object
	 * @cat Plugins/Dimensions
	 */
	offset: function(options, returnObject) {
		if (!this[0]) error();
		var x = 0, y = 0, sl = 0, st = 0,
		    elem = this[0], parent = this[0], op, parPos, elemPos = $.css(elem, 'position'),
		    mo = $.browser.mozilla, ie = $.browser.msie, oa = $.browser.opera,
		    sf = $.browser.safari, sf3 = $.browser.safari && parseInt($.browser.version) > 520,
		    absparent = false, relparent = false, 
		    options = $.extend({ margin: true, border: false, padding: false, scroll: true, lite: false, relativeTo: document.body }, options || {});
		
		// Use offsetLite if lite option is true
		if (options.lite) return this.offsetLite(options, returnObject);
		// Get the HTMLElement if relativeTo is a jquery collection
		if (options.relativeTo.jquery) options.relativeTo = options.relativeTo[0];
		
		if (elem.tagName == 'BODY') {
			// Safari 2 is the only one to get offsetLeft and offsetTop properties of the body "correct"
			// Except they all mess up when the body is positioned absolute or relative
			x = elem.offsetLeft;
			y = elem.offsetTop;
			// Mozilla ignores margin and subtracts border from body element
			if (mo) {
				x += num(elem, 'marginLeft') + (num(elem, 'borderLeftWidth')*2);
				y += num(elem, 'marginTop')  + (num(elem, 'borderTopWidth') *2);
			} else
			// Opera ignores margin
			if (oa) {
				x += num(elem, 'marginLeft');
				y += num(elem, 'marginTop');
			} else
			// IE does not add the border in Standards Mode
			if ((ie && jQuery.boxModel)) {
				x += num(elem, 'borderLeftWidth');
				y += num(elem, 'borderTopWidth');
			} else
			// Safari 3 doesn't not include border or margin
			if (sf3) {
				x += num(elem, 'marginLeft') + num(elem, 'borderLeftWidth');
				y += num(elem, 'marginTop')  + num(elem, 'borderTopWidth');
			}
		} else {
			do {
				parPos = $.css(parent, 'position');
			
				x += parent.offsetLeft;
				y += parent.offsetTop;

				// Mozilla and IE do not add the border
				if (mo || ie || sf3) {
					// add borders to offset
					x += num(parent, 'borderLeftWidth');
					y += num(parent, 'borderTopWidth');

					// Mozilla does not include the border on body if an element isn't positioned absolute and is without an absolute parent
					if (mo && parPos == 'absolute') absparent = true;
					// IE does not include the border on the body if an element is position static and without an absolute or relative parent
					if (ie && parPos == 'relative') relparent = true;
				}

				op = parent.offsetParent || document.body;
				if (options.scroll || mo) {
					do {
						if (options.scroll) {
							// get scroll offsets
							sl += parent.scrollLeft;
							st += parent.scrollTop;
						}
						
						// Opera sometimes incorrectly reports scroll offset for elements with display set to table-row or inline
						if (oa && ($.css(parent, 'display') || '').match(/table-row|inline/)) {
							sl = sl - ((parent.scrollLeft == parent.offsetLeft) ? parent.scrollLeft : 0);
							st = st - ((parent.scrollTop == parent.offsetTop) ? parent.scrollTop : 0);
						}
				
						// Mozilla does not add the border for a parent that has overflow set to anything but visible
						if (mo && parent != elem && $.css(parent, 'overflow') != 'visible') {
							x += num(parent, 'borderLeftWidth');
							y += num(parent, 'borderTopWidth');
						}
				
						parent = parent.parentNode;
					} while (parent != op);
				}
				parent = op;
				
				// exit the loop if we are at the relativeTo option but not if it is the body or html tag
				if (parent == options.relativeTo && !(parent.tagName == 'BODY' || parent.tagName == 'HTML'))  {
					// Mozilla does not add the border for a parent that has overflow set to anything but visible
					if (mo && parent != elem && $.css(parent, 'overflow') != 'visible') {
						x += num(parent, 'borderLeftWidth');
						y += num(parent, 'borderTopWidth');
					}
					// Safari 2 and opera includes border on positioned parents
					if ( ((sf && !sf3) || oa) && parPos != 'static' ) {
						x -= num(op, 'borderLeftWidth');
						y -= num(op, 'borderTopWidth');
					}
					break;
				}
				if (parent.tagName == 'BODY' || parent.tagName == 'HTML') {
					// Safari 2 and IE Standards Mode doesn't add the body margin for elments positioned with static or relative
					if (((sf && !sf3) || (ie && $.boxModel)) && elemPos != 'absolute' && elemPos != 'fixed') {
						x += num(parent, 'marginLeft');
						y += num(parent, 'marginTop');
					}
					// Safari 3 does not include the border on body
					// Mozilla does not include the border on body if an element isn't positioned absolute and is without an absolute parent
					// IE does not include the border on the body if an element is positioned static and without an absolute or relative parent
					if ( sf3 || (mo && !absparent && elemPos != 'fixed') || 
					     (ie && elemPos == 'static' && !relparent) ) {
						x += num(parent, 'borderLeftWidth');
						y += num(parent, 'borderTopWidth');
					}
					break; // Exit the loop
				}
			} while (parent);
		}

		var returnValue = handleOffsetReturn(elem, options, x, y, sl, st);

		if (returnObject) { $.extend(returnObject, returnValue); return this; }
		else              { return returnValue; }
	},
	
	/**
	 * Gets the location of the element in pixels from the top left corner of the viewport.
	 * This method is much faster than offset but not as accurate when borders and margins are
	 * on the element and/or its parents. This method can be invoked
	 * by setting the lite option to true in the offset method.
	 * The offsetLite method takes an optional map of key value pairs to configure the way
	 * the offset is calculated. Here are the different options.
	 *
	 * (Boolean) margin - Should the margin of the element be included in the calculations? True by default.
	 * (Boolean) border - Should the border of the element be included in the calculations? False by default. 
	 * (Boolean) padding - Should the padding of the element be included in the calcuations? False by default. 
	 * (Boolean) scroll - Sould the scroll offsets of the parent elements be included int he calculations? True by default.
	 *                    When true it adds the total scroll offsets of all parents to the total offset and also adds two
	 *                    properties to the returned object, scrollTop and scrollLeft.
	 * (HTML Element) relativeTo - This should be a parent of the element and should have position (like absolute or relative).
	 *                             It will retreive the offset relative to this parent element. By default it is the body element.
	 *
	 * @name offsetLite
	 * @param Map options Optional settings to configure the way the offset is calculated.
	 * @param Object returnObject An object to store the return value in, so as not to break the chain. If passed in the
	 *                            chain will not be broken and the result will be assigned to this object.
	 * @type Object
	 * @cat Plugins/Dimensions
	 */
	offsetLite: function(options, returnObject) {
		if (!this[0]) error();
		var x = 0, y = 0, sl = 0, st = 0, parent = this[0], offsetParent, 
		    options = $.extend({ margin: true, border: false, padding: false, scroll: true, relativeTo: document.body }, options || {});
				
		// Get the HTMLElement if relativeTo is a jquery collection
		if (options.relativeTo.jquery) options.relativeTo = options.relativeTo[0];
		
		do {
			x += parent.offsetLeft;
			y += parent.offsetTop;

			offsetParent = parent.offsetParent || document.body;
			if (options.scroll) {
				// get scroll offsets
				do {
					sl += parent.scrollLeft;
					st += parent.scrollTop;
					parent = parent.parentNode;
				} while(parent != offsetParent);
			}
			parent = offsetParent;
		} while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML' && parent != options.relativeTo);

		var returnValue = handleOffsetReturn(this[0], options, x, y, sl, st);

		if (returnObject) { $.extend(returnObject, returnValue); return this; }
		else              { return returnValue; }
	},
	
	/**
	 * Returns a jQuery collection with the positioned parent of 
	 * the first matched element. This is the first parent of 
	 * the element that has position (as in relative or absolute).
	 *
	 * @name offsetParent
	 * @type jQuery
	 * @cat Plugins/Dimensions
	 */
	offsetParent: function() {
		if (!this[0]) error();
		var offsetParent = this[0].offsetParent;
		while ( offsetParent && (offsetParent.tagName != 'BODY' && $.css(offsetParent, 'position') == 'static') )
			offsetParent = offsetParent.offsetParent;
		return $(offsetParent);
	}
});

/**
 * Throws an error message when no elements are in the jQuery collection
 * @private
 */
var error = function() {
	throw "Dimensions: jQuery collection is empty";
};

/**
 * Handles converting a CSS Style into an Integer.
 * @private
 */
var num = function(el, prop) {
	return parseInt($.css(el.jquery?el[0]:el,prop))||0;
};

/**
 * Handles the return value of the offset and offsetLite methods.
 * @private
 */
var handleOffsetReturn = function(elem, options, x, y, sl, st) {
	if ( !options.margin ) {
		x -= num(elem, 'marginLeft');
		y -= num(elem, 'marginTop');
	}

	// Safari and Opera do not add the border for the element
	if ( options.border && (($.browser.safari && parseInt($.browser.version) < 520) || $.browser.opera) ) {
		x += num(elem, 'borderLeftWidth');
		y += num(elem, 'borderTopWidth');
	} else if ( !options.border && !(($.browser.safari && parseInt($.browser.version) < 520) || $.browser.opera) ) {
		x -= num(elem, 'borderLeftWidth');
		y -= num(elem, 'borderTopWidth');
	}

	if ( options.padding ) {
		x += num(elem, 'paddingLeft');
		y += num(elem, 'paddingTop');
	}
	
	// do not include scroll offset on the element ... opera sometimes reports scroll offset as actual offset
	if ( options.scroll && (!$.browser.opera || elem.offsetLeft != elem.scrollLeft && elem.offsetTop != elem.scrollLeft) ) {
		sl -= elem.scrollLeft;
		st -= elem.scrollTop;
	}

	return options.scroll ? { top: y - st, left: x - sl, scrollTop:  st, scrollLeft: sl }
	                      : { top: y, left: x };
};

/**
 * Gets the width of the OS scrollbar
 * @private
 */
var scrollbarWidth = 0;
var getScrollbarWidth = function() {
	if (!scrollbarWidth) {
		var testEl = $('<div>')
				.css({
					width: 100,
					height: 100,
					overflow: 'auto',
					position: 'absolute',
					top: -1000,
					left: -1000
				})
				.appendTo('body');
		scrollbarWidth = 100 - testEl
			.append('<div>')
			.find('div')
				.css({
					width: '100%',
					height: 200
				})
				.width();
		testEl.remove();
	}
	return scrollbarWidth;
};

})(jQuery);
// file seperator

/**
* hoverIntent is similar to jQuery's built-in "hover" function except that
* instead of firing the onMouseOver event immediately, hoverIntent checks
* to see if the user's mouse has slowed down (beneath the sensitivity
* threshold) before firing the onMouseOver event.
* 
* hoverIntent r5 // 2007.03.27 // jQuery 1.1.2
* <http://cherne.net/brian/resources/jquery.hoverIntent.html>
* 
* hoverIntent is currently available for use in all personal or commercial 
* projects under both MIT and GPL licenses. This means that you can choose 
* the license that best suits your project, and use it accordingly.
* 
* // basic usage (just like .hover) receives onMouseOver and onMouseOut functions
* $("ul li").hoverIntent( showNav , hideNav );
* 
* // advanced usage receives configuration object only
* $("ul li").hoverIntent({
*	sensitivity: 2, // number = sensitivity threshold (must be 1 or higher)
*	interval: 50,   // number = milliseconds of polling interval
*	over: showNav,  // function = onMouseOver callback (required)
*	timeout: 100,   // number = milliseconds delay before onMouseOut function call
*	out: hideNav    // function = onMouseOut callback (required)
* });
* 
* @param  f  onMouseOver function || An object with configuration options
* @param  g  onMouseOut function  || Nothing (use configuration options object)
* @return    The object (aka "this") that called hoverIntent, and the event object
* @author    Brian Cherne <brian@cherne.net>
*/
(function($) {
	$.fn.hoverIntent = function(f,g) {
		// default configuration options
		var cfg = {
			sensitivity: 7,
			interval: 100,
			timeout: 0
		};
		// override configuration options with user supplied object
		cfg = $.extend(cfg, g ? { over: f, out: g } : f );

		// instantiate variables
		// cX, cY = current X and Y position of mouse, updated by mousemove event
		// pX, pY = previous X and Y position of mouse, set by mouseover and polling interval
		var cX, cY, pX, pY;

		// A private function for getting mouse position
		var track = function(ev) {
			cX = ev.pageX;
			cY = ev.pageY;
		};

		// A private function for comparing current and previous mouse position
		var compare = function(ev,ob) {
			ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t);
			// compare mouse positions to see if they've crossed the threshold
			if ( ( Math.abs(pX-cX) + Math.abs(pY-cY) ) < cfg.sensitivity ) {
				$(ob).unbind("mousemove",track);
				// set hoverIntent state to true (so mouseOut can be called)
				ob.hoverIntent_s = 1;
				return cfg.over.apply(ob,[ev]);
			} else {
				// set previous coordinates for next time
				pX = cX; pY = cY;
				// use self-calling timeout, guarantees intervals are spaced out properly (avoids JavaScript timer bugs)
				ob.hoverIntent_t = setTimeout( function(){compare(ev, ob);} , cfg.interval );
			}
		};

		// A private function for delaying the mouseOut function
		var delay = function(ev,ob) {
			ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t);
			ob.hoverIntent_s = 0;
			return cfg.out.apply(ob,[ev]);
		};

		// A private function for handling mouse 'hovering'
		var handleHover = function(e) {
			// next three lines copied from jQuery.hover, ignore children onMouseOver/onMouseOut
			var p = (e.type == "mouseover" ? e.fromElement : e.toElement) || e.relatedTarget;
			while ( p && p != this ) { try { p = p.parentNode; } catch(e) { p = this; } }
			if ( p == this ) { return false; }

			// copy objects to be passed into t (required for event object to be passed in IE)
			var ev = jQuery.extend({},e);
			var ob = this;

			// cancel hoverIntent timer if it exists
			if (ob.hoverIntent_t) { ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t); }

			// else e.type == "onmouseover"
			if (e.type == "mouseover") {
				// set "previous" X and Y position based on initial entry point
				pX = ev.pageX; pY = ev.pageY;
				// update "current" X and Y position based on mousemove
				$(ob).bind("mousemove",track);
				// start polling interval (self-calling timeout) to compare mouse coordinates over time
				if (ob.hoverIntent_s != 1) { ob.hoverIntent_t = setTimeout( function(){compare(ev,ob);} , cfg.interval );}

			// else e.type == "onmouseout"
			} else {
				// unbind expensive mousemove event
				$(ob).unbind("mousemove",track);
				// if hoverIntent state is true, then call the mouseOut function after the specified delay
				if (ob.hoverIntent_s == 1) { ob.hoverIntent_t = setTimeout( function(){delay(ev,ob);} , cfg.timeout );}
			}
		};

		// bind the function to the two event listeners
		return this.mouseover(handleHover).mouseout(handleHover);
	};
})(jQuery);
// file seperator

/**
 * Interface Elements for jQuery
 * Accordion
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */

/**
 * Create an accordion from a HTML structure
 *
 * @example $('#myAccordion').Accordion(
 *				{
 *					headerSelector	: 'dt',
 *					panelSelector	: 'dd',
 *					activeClass		: 'myAccordionActive',
 *					hoverClass		: 'myAccordionHover',
 *					panelHeight		: 200,
 *					speed			: 300
 *				}
 *			);
 * @desc Converts definition list with id 'myAccordion' into an accordion width dt tags as headers and dd tags as panels
 * 
 * @name Accordion
 * @description Create an accordion from a HTML structure
 * @param Hash hash A hash of parameters
 * @option Integer panelHeight the pannels' height
 * @option String headerSelector selector for header elements
 * @option String panelSelector selector for panel elements
 * @option String activeClass (optional) CSS Class for active header
 * @option String hoverClass (optional) CSS Class for hovered header
 * @option Function onShow (optional) callback called whenever an pannel gets active
 * @option Function onHide (optional) callback called whenever an pannel gets incative
 * @option Function onClick (optional) callback called just before an panel gets active
 * @option Mixed speed (optional) animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
 * @option Integer crrentPanel (otional) the active panel on initialisation
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.iAccordion = {
	build : function(options)
	{
		return this.each(
			function()
			{
				if (!options.headerSelector || !options.panelSelector)
					return;
				var el = this;
				el.accordionCfg = {
					panelHeight			: options.panelHeight||300,
					headerSelector		: options.headerSelector,
					panelSelector		: options.panelSelector,
					activeClass			: options.activeClass||'fakeAccordionClass',
					hoverClass			: options.hoverClass||'fakeAccordionClass',
					onShow				: options.onShow && typeof options.onShow == 'function' ? options.onShow : false,
					onHide				: options.onShow && typeof options.onHide == 'function' ? options.onHide : false,
					onClick				: options.onClick && typeof options.onClick == 'function' ? options.onClick : false,
					headers				: jQuery(options.headerSelector, this),
					panels				: jQuery(options.panelSelector, this),
					speed				: options.speed||400,
					currentPanel		: options.currentPanel||0
				};
				el.accordionCfg.panels
					.hide()
					.css('height', '1px')
					.eq(0)
					.css(
						{
							height: el.accordionCfg.panelHeight + 'px',
							display: 'block'
						}
					)
					.end();
					
				el.accordionCfg.headers
				.each(
					function(nr)
					{
						this.accordionPos = nr;
					}
				)
				.hover(
					function()
					{
						jQuery(this).addClass(el.accordionCfg.hoverClass);
					},
					function()
					{
						jQuery(this).removeClass(el.accordionCfg.hoverClass);
					}
				)
				.bind(
					'click',
					function(e)
					{
						if (el.accordionCfg.currentPanel == this.accordionPos)
							return;
						el.accordionCfg.headers
							.eq(el.accordionCfg.currentPanel)
							.removeClass(el.accordionCfg.activeClass)
							.end()
							.eq(this.accordionPos)
							.addClass(el.accordionCfg.activeClass)
							.end();
						el.accordionCfg.panels
						.eq(el.accordionCfg.currentPanel)
							.animate(
								{height:0},
								el.accordionCfg.speed,
								function()
								{
									this.style.display = 'none';
									if (el.accordionCfg.onHide) {
										el.accordionCfg.onHide.apply(el, [this]);
									}
								}
							)
						.end()
						.eq(this.accordionPos)
							.show()
							.animate (
								{height:el.accordionCfg.panelHeight},
								el.accordionCfg.speed,
								function()
								{
									this.style.display = 'block';
									if (el.accordionCfg.onShow) {
										el.accordionCfg.onShow.apply(el, [this]);
									}
								}
							)
						.end();
						
						if (el.accordionCfg.onClick) {
							el.accordionCfg.onClick.apply(
								el, 
								[
									this, 
									el.accordionCfg.panels.get(this.accordionPos),
									el.accordionCfg.headers.get(el.accordionCfg.currentPanel),
									el.accordionCfg.panels.get(el.accordionCfg.currentPanel)
								]
							);
						}
						el.accordionCfg.currentPanel = this.accordionPos;
					}
				)
				.eq(0)
				.addClass(el.accordionCfg.activeClass)
				.end();
				jQuery(this)
					.css('height', jQuery(this).css('height'))
					.css('overflow', 'hidden');
			}
		);
	}
};

jQuery.fn.Accordion = jQuery.iAccordion.build;/**
 * Interface Elements for jQuery
 * 3D Carousel
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */
/**
 * Created a 3D Carousel from a list of images, with reflections and animated by mouse position
 * 
 * @example window.onload = 
 *			function()
 *			{
 *				$('#carousel').Carousel(
 *					{
 *						itemWidth: 110,
 *						itemHeight: 62,
 *						itemMinWidth: 50,
 *						items: 'a',
 *						reflections: .5,
 *						rotationSpeed: 1.8
 *					}
 *				);
 *			}
 * HTML
 *			<div id="carousel">
 *				<a href="" title=""><img src="" width="100%" /></a>
 *				<a href="" title=""><img src="" width="100%" /></a>
 *				<a href="" title=""><img src="" width="100%" /></a>
 *				<a href="" title=""><img src="" width="100%" /></a>
 *				<a href="" title=""><img src="" width="100%" /></a>
 *			</div>
 * CSS
 *			#carousel
 *			{
 *				width: 700px;
 *				height: 150px;
 *				background-color: #111;
 *				position: absolute;
 *				top: 200px;
 *				left: 100px;
 *			}
 *			#carousel a
 *			{
 *				position: absolute;
 *				width: 110px;
 *			}
 *
 * @desc Creates a 3D carousel from all images inside div tag with id 'carousel'
 *
 *
 * @name 3D Carousel
 * @description Created a 3D Carousel from a list of images, with reflections and animated by mouse position
 * @param Hash hash A hash of parameters
 * @option String items items selection
 * @option Integer itemWidth the max width for each item
 * @option Integer itemHeight the max height for each item
 * @option Integer itemMinWidth the minimum width for each item, the height is automaticaly calculated to keep proportions
 * @option Float rotationSpeed the speed for rotation animation
 * @option Float reflectionSize the reflection size a fraction from items' height
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.iCarousel = {
	
	build : function(options)
	{
		return this.each(
			function()
			{
				var el = this;
				var increment = 2*Math.PI/360;
				var maxRotation = 2*Math.PI;
				if(jQuery(el).css('position') != 'relative' && jQuery(el).css('position') != 'absolute') {
					jQuery(el).css('position', 'relative');
				}
				el.carouselCfg = {
					items : jQuery(options.items, this),
					itemWidth : options.itemWidth,
					itemHeight : options.itemHeight,
					itemMinWidth : options.itemMinWidth,
					maxRotation : maxRotation,
					size : jQuery.iUtil.getSize(this),
					position : jQuery.iUtil.getPosition(this),
					start : Math.PI/2,
					rotationSpeed : options.rotationSpeed,
					reflectionSize : options.reflections,
					reflections : [],
					protectRotation : false,
					increment: 2*Math.PI/360
				};
				el.carouselCfg.radiusX = (el.carouselCfg.size.w - el.carouselCfg.itemWidth)/2;
				el.carouselCfg.radiusY =  (el.carouselCfg.size.h - el.carouselCfg.itemHeight - el.carouselCfg.itemHeight * el.carouselCfg.reflectionSize)/2;
				el.carouselCfg.step =  2*Math.PI/el.carouselCfg.items.size();
				el.carouselCfg.paddingX = el.carouselCfg.size.w/2;
				el.carouselCfg.paddingY = el.carouselCfg.size.h/2 - el.carouselCfg.itemHeight * el.carouselCfg.reflectionSize;
				var reflexions = document.createElement('div');
				jQuery(reflexions)
					.css(
						{
							position: 'absolute',
							zIndex: 1,
							top: 0,
							left: 0
						}
					);
				jQuery(el).append(reflexions);
				el.carouselCfg.items
					.each(
						function(nr)
						{
							image = jQuery('img', this).get(0);
							height = parseInt(el.carouselCfg.itemHeight*el.carouselCfg.reflectionSize);
							if (jQuery.browser.msie) {
								canvas = document.createElement('img');
								jQuery(canvas).css('position', 'absolute');
								canvas.src = image.src;				
								canvas.style.filter = 'flipv progid:DXImageTransform.Microsoft.Alpha(opacity=60, style=1, finishOpacity=0, startx=0, starty=0, finishx=0)';
					
							} else {
								canvas = document.createElement('canvas');
								if (canvas.getContext) {
									context = canvas.getContext("2d");
									canvas.style.position = 'absolute';
									canvas.style.height = height +'px';
									canvas.style.width = el.carouselCfg.itemWidth+'px';
									canvas.height = height;
									canvas.width = el.carouselCfg.itemWidth;
									context.save();
						
									context.translate(0,height);
									context.scale(1,-1);
									
									context.drawImage(
										image, 
										0, 
										0, 
										el.carouselCfg.itemWidth, 
										height
									);
					
									context.restore();
									
									context.globalCompositeOperation = "destination-out";
									var gradient = context.createLinearGradient(
										0, 
										0, 
										0, 
										height
									);
									
									gradient.addColorStop(1, "rgba(255, 255, 255, 1)");
									gradient.addColorStop(0, "rgba(255, 255, 255, 0.6)");
						
									context.fillStyle = gradient;
									if (navigator.appVersion.indexOf('WebKit') != -1) {
										context.fill();
									} else {
										context.fillRect(
											0, 
											0, 
											el.carouselCfg.itemWidth, 
											height
										);
									}
								}
							}
							
							el.carouselCfg.reflections[nr] = canvas;
							jQuery(reflexions).append(canvas);
						}
					)
					.bind(
						'mouseover',
						function(e)
						{
							el.carouselCfg.protectRotation = true;
							el.carouselCfg.speed = el.carouselCfg.increment*0.1 * el.carouselCfg.speed / Math.abs(el.carouselCfg.speed);
							return false;
						}
					)
					.bind(
						'mouseout',
						function(e)
						{
							el.carouselCfg.protectRotation = false;
							return false;
						}
					);
				jQuery.iCarousel.positionItems(el);
				el.carouselCfg.speed = el.carouselCfg.increment*0.2;
				el.carouselCfg.rotationTimer = window.setInterval(
					function()
					{
						el.carouselCfg.start += el.carouselCfg.speed;
						if (el.carouselCfg.start > maxRotation)
							el.carouselCfg.start = 0;
						jQuery.iCarousel.positionItems(el);
					},
					20
				);
				jQuery(el)
					.bind(
						'mouseout',
						function()
						{
							el.carouselCfg.speed = el.carouselCfg.increment*0.2 * el.carouselCfg.speed / Math.abs(el.carouselCfg.speed);
						}
					)
					.bind(
						'mousemove',
						function(e)
						{
							if (el.carouselCfg.protectRotation == false) {
								pointer = jQuery.iUtil.getPointer(e);
								mousex =  el.carouselCfg.size.w - pointer.x + el.carouselCfg.position.x;
								el.carouselCfg.speed = el.carouselCfg.rotationSpeed * el.carouselCfg.increment * (el.carouselCfg.size.w/2 - mousex) / (el.carouselCfg.size.w/2);
							}
						}
					);
			}
		);
	},

	positionItems : function(el)
	{
		el.carouselCfg.items.each(
			function (nr)
			{
				angle = el.carouselCfg.start+nr*el.carouselCfg.step;
				x = el.carouselCfg.radiusX*Math.cos(angle);
				y = el.carouselCfg.radiusY*Math.sin(angle) ;
				itemZIndex = parseInt(100*(el.carouselCfg.radiusY+y)/(2*el.carouselCfg.radiusY));
				parte = (el.carouselCfg.radiusY+y)/(2*el.carouselCfg.radiusY);
				
				width = parseInt((el.carouselCfg.itemWidth - el.carouselCfg.itemMinWidth) * parte + el.carouselCfg.itemMinWidth);
				height = parseInt(width * el.carouselCfg.itemHeight / el.carouselCfg.itemWidth);
				this.style.top = el.carouselCfg.paddingY + y - height/2 + "px";
	     		this.style.left = el.carouselCfg.paddingX + x - width/2 + "px";
	     		this.style.width = width + "px";
	     		this.style.height = height + "px";
	     		this.style.zIndex = itemZIndex;
				el.carouselCfg.reflections[nr].style.top = parseInt(el.carouselCfg.paddingY + y + height - 1 - height/2) + "px";
				el.carouselCfg.reflections[nr].style.left = parseInt(el.carouselCfg.paddingX + x - width/2) + "px";
				el.carouselCfg.reflections[nr].style.width = width + "px";
				el.carouselCfg.reflections[nr].style.height = parseInt(height * el.carouselCfg.reflectionSize) + "px";
			}
		);
	}
};
jQuery.fn.Carousel = jQuery.iCarousel.build;/**
 * Interface Elements for jQuery
 * Easing formulas
 *
 * http://interface.eyecon.ro
 *
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 */
 
/**
 * Starting with jQuery 1.1  the fx function accepts easing formulas that can be used with .animation() and most of FX plugins from Interface. The object can be extended to accept new easing formulas
 */
 
 jQuery.extend({	
	/**
	 *
	 * @param Integer p period step in animation
	 * @param Integer n current time
	 * @param Mixed firstNum begin value
	 * @param Mixed delta change in
	 * @param Integer duration duration
	 */
	easing :  {
		linear: function(p, n, firstNum, delta, duration) {
			return ((-Math.cos(p*Math.PI)/2) + 0.5) * delta + firstNum;
		},
		
		easein: function(p, n, firstNum, delta, duration) {
			return delta*(n/=duration)*n*n + firstNum;
		},
		
		easeout: function(p, n, firstNum, delta, duration) {
			return -delta * ((n=n/duration-1)*n*n*n - 1) + firstNum;
		},
		
		easeboth: function(p, n, firstNum, delta, duration) {
			if ((n/=duration/2) < 1)
				return delta/2*n*n*n*n + firstNum;
				return -delta/2 * ((n-=2)*n*n*n - 2) + firstNum;
		},
		
		bounceout: function(p, n, firstNum, delta, duration) {
			if ((n/=duration) < (1/2.75)) {
				return delta*(7.5625*n*n) + firstNum;
			} else if (n < (2/2.75)) {
				return delta*(7.5625*(n-=(1.5/2.75))*n + .75) + firstNum;
			} else if (n < (2.5/2.75)) {
				return delta*(7.5625*(n-=(2.25/2.75))*n + .9375) + firstNum;
			} else {
				return delta*(7.5625*(n-=(2.625/2.75))*n + .984375) + firstNum;
			}
		},
		
		bouncein: function(p, n, firstNum, delta, duration) {
			if (jQuery.easing.bounceout)
				return delta - jQuery.easing.bounceout (p, duration - n, 0, delta, duration) + firstNum;
			return firstNum + delta;
		},
		
		bounceboth: function(p, n, firstNum, delta, duration) {
			if (jQuery.easing.bouncein && jQuery.easing.bounceout)
				if (n < duration/2)
					return jQuery.easing.bouncein(p, n*2, 0, delta, duration) * .5 + firstNum;
				return jQuery.easing.bounceout(p, n*2-duration, 0, delta, duration) * .5 + delta*.5 + firstNum; 
			return firstNum + delta;
		},
		
		elasticin: function(p, n, firstNum, delta, duration) {
			var a, s;
   			if (n == 0)
   				return firstNum;
   			if ((n/=duration)==1)
   				return firstNum+delta;
   			a = delta * 0.3;
   			p=duration*.3;
			if (a < Math.abs(delta)) {
				a=delta;
				s=p/4;
			} else { 
				s = p/(2*Math.PI) * Math.asin (delta/a);
			}
			return -(a*Math.pow(2,10*(n-=1)) * Math.sin( (n*duration-s)*(2*Math.PI)/p )) + firstNum; 
		},
		
		elasticout:function(p, n, firstNum, delta, duration) {
			var a, s;
			if (n==0)
				return firstNum;
			if ((n/=duration/2)==2)
				return firstNum + delta;
   			a = delta * 0.3;
   			p=duration*.3;
			if (a < Math.abs(delta)){
				a = delta;
				s=p/4;
			} else { 
				s = p/(2*Math.PI) * Math.asin (delta/a);
			}
			return a*Math.pow(2,-10*n) * Math.sin( (n*duration-s)*(2*Math.PI)/p ) + delta + firstNum;
		},
		
		elasticboth: function(p, n, firstNum, delta, duration) {
			var a, s;
			if (n==0)
				return firstNum;
			if ((n/=duration/2)==2)
				return firstNum + delta;
   			a = delta * 0.3;
   			p=duration*.3;
			if (a < Math.abs(delta)){
				a = delta;
				s=p/4;
			} else { 
				s = p/(2*Math.PI) * Math.asin (delta/a);
			}
			if (n < 1) {
				return -.5*(a*Math.pow(2,10*(n-=1)) * Math.sin( (n*duration-s)*(2*Math.PI)/p )) + firstNum;
			}
			return a*Math.pow(2,-10*(n-=1)) * Math.sin( (n*duration-s)*(2*Math.PI)/p )*.5 + delta + firstNum; 
		}
	}
});/**
 * Interface Elements for jQuery
 * Fisheye menu
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */

/**
 * Build a Fisheye menu from a list of links
 *
 * @name Fisheye
 * @description Build a Fisheye menu from a list of links
 * @param Hash hash A hash of parameters
 * @option String items items selection
 * @option String container container element
 * @option Integer itemWidth the minimum width for each item
 * @option Integer maxWidth the maximum width for each item
 * @option String itemsText selection of element that contains the text for each item
 * @option Integer proximity the distance from element that make item to interact
 * @option String valign vertical alignment
 * @option String halign horizontal alignment
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.iFisheye = {
	
	build : function(options)
	{
	
		return this.each(
			function()
			{
				var el = this;
				el.fisheyeCfg = {
					items : jQuery(options.items, this),
					container: jQuery(options.container, this),
					pos : jQuery.iUtil.getPosition(this),
					itemWidth: options.itemWidth,
					itemsText: options.itemsText,
					proximity: options.proximity,
					valign: options.valign,
					halign: options.halign,
					maxWidth : options.maxWidth
				};
				jQuery.iFisheye.positionContainer(el, 0);
				jQuery(window).bind(
					'resize',
					function()
					{
						el.fisheyeCfg.pos = jQuery.iUtil.getPosition(el);
						jQuery.iFisheye.positionContainer(el, 0);
						jQuery.iFisheye.positionItems(el);
					}
				);
				jQuery.iFisheye.positionItems(el);
				el.fisheyeCfg.items
					.bind(
						'mouseover',
						function()
						{
							jQuery(el.fisheyeCfg.itemsText, this).get(0).style.display = 'block';
						}
					)
					.bind(
						'mouseout',
						function()
						{
							jQuery(el.fisheyeCfg.itemsText, this).get(0).style.display = 'none';
						}
					);
				jQuery(document).bind(
					'mousemove',
					function(e)
					{
						var pointer = jQuery.iUtil.getPointer(e);
						var toAdd = 0;
						if (el.fisheyeCfg.halign && el.fisheyeCfg.halign == 'center')
							var posx = pointer.x - el.fisheyeCfg.pos.x - (el.offsetWidth - el.fisheyeCfg.itemWidth * el.fisheyeCfg.items.size())/2 - el.fisheyeCfg.itemWidth/2;
						else if (el.fisheyeCfg.halign && el.fisheyeCfg.halign == 'right')
							var posx = pointer.x - el.fisheyeCfg.pos.x - el.offsetWidth + el.fisheyeCfg.itemWidth * el.fisheyeCfg.items.size();
						else 
							var posx = pointer.x - el.fisheyeCfg.pos.x;
						var posy = Math.pow(pointer.y - el.fisheyeCfg.pos.y - el.offsetHeight/2,2);
						el.fisheyeCfg.items.each(
							function(nr)
							{
								distance = Math.sqrt(
									Math.pow(posx - nr*el.fisheyeCfg.itemWidth, 2)
									+ posy
								);
								distance -= el.fisheyeCfg.itemWidth/2;
								
								distance = distance < 0 ? 0 : distance;
								distance = distance > el.fisheyeCfg.proximity ? el.fisheyeCfg.proximity : distance;
								distance = el.fisheyeCfg.proximity - distance;
								
								extraWidth = el.fisheyeCfg.maxWidth * distance/el.fisheyeCfg.proximity;
								
								this.style.width = el.fisheyeCfg.itemWidth + extraWidth + 'px';
								this.style.left = el.fisheyeCfg.itemWidth * nr + toAdd + 'px';
								toAdd += extraWidth;
							}
						);
						jQuery.iFisheye.positionContainer(el, toAdd);
					}
				);
			}
		)
	},
	
	positionContainer : function(el, toAdd)
	{
		if (el.fisheyeCfg.halign)
			if (el.fisheyeCfg.halign == 'center')
				el.fisheyeCfg.container.get(0).style.left = (el.offsetWidth - el.fisheyeCfg.itemWidth * el.fisheyeCfg.items.size())/2 - toAdd/2 + 'px';
			else if (el.fisheyeCfg.halign == 'left')
				el.fisheyeCfg.container.get(0).style.left =  - toAdd/el.fisheyeCfg.items.size() + 'px';
			else if (el.fisheyeCfg.halign == 'right')
				el.fisheyeCfg.container.get(0).style.left =  (el.offsetWidth - el.fisheyeCfg.itemWidth * el.fisheyeCfg.items.size()) - toAdd/2 + 'px';
		el.fisheyeCfg.container.get(0).style.width = el.fisheyeCfg.itemWidth * el.fisheyeCfg.items.size() + toAdd + 'px';
	},
	
	positionItems : function(el)
	{
		el.fisheyeCfg.items.each(
			function(nr)
			{
				this.style.width = el.fisheyeCfg.itemWidth + 'px';
				this.style.left = el.fisheyeCfg.itemWidth * nr + 'px';
			}
		);
	}
};

jQuery.fn.Fisheye = jQuery.iFisheye.build;/**
 * Interface Elements for jQuery
 * Autocompleter
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *  
 */

/**
 * Attach AJAX driven autocomplete/sugestion box to text input fields.
 *
 * 
 * 
 * @name Autocomplete
 * @description Attach AJAX driven autocomplete/sugestion box to text input fields.
 * @param Hash hash A hash of parameters
 * @option String source the URL to request
 * @option Integer delay (optional) the delayed time to start the AJAX request
 * @option Boolean autofill (optional) when true the first sugested value fills the input
 * @option String helperClass (optional) the CSS class applied to sugestion box
 * @option String selectClass (optional) the CSS class applied to selected/hovered item
 * @option Integer minchars (optional) the number of characters needed before starting AJAX request
 * @option Hash fx (optional) {type:[slide|blind|fade]; duration: integer} the fx type to apply to sugestion box and duration for that fx
 * @option Function onSelect (optional) A function to be executed whenever an item it is selected
 * @option Function onShow (optional) A function to be executed whenever the suggection box is displayed
 * @option Function onHide (optional) A function to be executed whenever the suggection box is hidden
 * @option Function onHighlight (optional) A function to be executed whenever an item it is highlighted
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.iAuto = {
	helper : null,
	content : null,
	iframe: null,
	timer : null,
	lastValue: null,
	currentValue: null,
	subject: null,
	selectedItem : null,
	items: null,
	
	empty : function()
	{
		jQuery.iAuto.content.empty();
		if (jQuery.iAuto.iframe) {
			jQuery.iAuto.iframe.hide();
		}
	},

	clear : function()
	{
		jQuery.iAuto.items = null;
		jQuery.iAuto.selectedItem = null;
		jQuery.iAuto.lastValue = jQuery.iAuto.subject.value;
		if(jQuery.iAuto.helper.css('display') == 'block') {
			if (jQuery.iAuto.subject.autoCFG.fx) {
				switch(jQuery.iAuto.subject.autoCFG.fx.type) {
					case 'fade':
						jQuery.iAuto.helper.fadeOut(jQuery.iAuto.subject.autoCFG.fx.duration, jQuery.iAuto.empty);
						break;
					case 'slide':
						jQuery.iAuto.helper.SlideOutUp(jQuery.iAuto.subject.autoCFG.fx.duration, jQuery.iAuto.empty);
						break;
					case 'blind':
						jQuery.iAuto.helper.BlindUp(jQuery.iAuto.subject.autoCFG.fx.duration, jQuery.iAuto.empty);
						break;
				}
			} else {
				jQuery.iAuto.helper.hide();
			}
			if (jQuery.iAuto.subject.autoCFG.onHide)
				jQuery.iAuto.subject.autoCFG.onHide.apply(jQuery.iAuto.subject, [jQuery.iAuto.helper, jQuery.iAuto.iframe]);
		} else {
			jQuery.iAuto.empty();
		}
		window.clearTimeout(jQuery.iAuto.timer);
	},

	update : function ()
	{
		var subject = jQuery.iAuto.subject;
		var subjectValue = jQuery.iAuto.getFieldValues(subject);
		//var selectionStart = jQuery.iAuto.getSelectionStart(subject);
		if (subject && subjectValue.item != jQuery.iAuto.lastValue && subjectValue.item.length >= subject.autoCFG.minchars) {
			jQuery.iAuto.lastValue = subjectValue.item;
			jQuery.iAuto.currentValue = subjectValue.item;

			data = {
				field: jQuery(subject).attr('name')||'field',
				value: subjectValue.item
			};

			jQuery.ajax(
				{
					type: 'POST',
					data: jQuery.param(data),
					success: function(xml)
					{
						subject.autoCFG.lastSuggestion = jQuery('item',xml);
						size = subject.autoCFG.lastSuggestion.size();
						if (size > 0) {
							var toWrite = '';
							subject.autoCFG.lastSuggestion.each(
								function(nr)
								{
									toWrite += '<li rel="' + jQuery('value', this).text() + '" dir="' + nr + '" style="cursor: default;">' + jQuery('text', this).text() + '</li>';
								}
							);
							if (subject.autoCFG.autofill) {
								var valueToAdd = jQuery('value', subject.autoCFG.lastSuggestion.get(0)).text();
								subject.value = subjectValue.pre + valueToAdd + subject.autoCFG.multipleSeparator + subjectValue.post;
								jQuery.iAuto.selection(
									subject, 
									subjectValue.item.length != valueToAdd.length ? (subjectValue.pre.length + subjectValue.item.length) : valueToAdd.length,
									subjectValue.item.length != valueToAdd.length ? (subjectValue.pre.length + valueToAdd.length) : valueToAdd.length
								);
							}
							
							if (size > 0) {
								jQuery.iAuto.writeItems(subject, toWrite);
							} else {
								jQuery.iAuto.clear();
							}
						} else {
							jQuery.iAuto.clear();
						}
					},
					url : subject.autoCFG.source
				}
			);
		}
	},
	
	writeItems : function(subject, toWrite)
	{
		jQuery.iAuto.content.html(toWrite);
		jQuery.iAuto.items = jQuery('li', jQuery.iAuto.content.get(0));
		jQuery.iAuto.items
			.mouseover(jQuery.iAuto.hoverItem)
			.bind('click', jQuery.iAuto.clickItem);
		var position = jQuery.iUtil.getPosition(subject);
		var size = jQuery.iUtil.getSize(subject);
		jQuery.iAuto.helper
			.css('top', position.y + size.hb + 'px')
			.css('left', position.x +  'px')
			.addClass(subject.autoCFG.helperClass);
		if (jQuery.iAuto.iframe) {
			jQuery.iAuto.iframe
				.css('display', 'block')
				.css('top', position.y + size.hb + 'px')
				.css('left', position.x +  'px')
				.css('width', jQuery.iAuto.helper.css('width'))
				.css('height', jQuery.iAuto.helper.css('height'));
		}
		jQuery.iAuto.selectedItem = 0;
		jQuery.iAuto.items.get(0).className = subject.autoCFG.selectClass;
		jQuery.iAuto.applyOn(subject,subject.autoCFG.lastSuggestion.get(0), 'onHighlight');
		
		if (jQuery.iAuto.helper.css('display') == 'none') {
			if (subject.autoCFG.inputWidth) {
				var borders = jQuery.iUtil.getPadding(subject, true);
				var paddings = jQuery.iUtil.getBorder(subject, true);
				jQuery.iAuto.helper.css('width', subject.offsetWidth - (jQuery.boxModel ? (borders.l + borders.r + paddings.l + paddings.r) : 0 ) + 'px');
			}
			if (subject.autoCFG.fx) {
				switch(subject.autoCFG.fx.type) {
					case 'fade':
						jQuery.iAuto.helper.fadeIn(subject.autoCFG.fx.duration);
						break;
					case 'slide':
						jQuery.iAuto.helper.SlideInUp(subject.autoCFG.fx.duration);
						break;
					case 'blind':
						jQuery.iAuto.helper.BlindDown(subject.autoCFG.fx.duration);
						break;
				}
			} else {
				jQuery.iAuto.helper.show();
			}
			
			if (jQuery.iAuto.subject.autoCFG.onShow)
				jQuery.iAuto.subject.autoCFG.onShow.apply(jQuery.iAuto.subject, [jQuery.iAuto.helper, jQuery.iAuto.iframe]);
		}
	},
	
	checkCache : function()
	{
		var subject = this;
		if (subject.autoCFG.lastSuggestion) {
			
			jQuery.iAuto.lastValue = subject.value;
			jQuery.iAuto.currentValue = subject.value;
			
			var toWrite = '';
			subject.autoCFG.lastSuggestion.each(
				function(nr)
				{
					value = jQuery('value', this).text().toLowerCase();
					inputValue = subject.value.toLowerCase();
					if (value.indexOf(inputValue) == 0) {
						toWrite += '<li rel="' + jQuery('value', this).text() + '" dir="' + nr + '" style="cursor: default;">' + jQuery('text', this).text() + '</li>';
					}
				}
			);
			
			if (toWrite != '') {
				jQuery.iAuto.writeItems(subject, toWrite);
				
				this.autoCFG.inCache = true;
				return;
			}
		}
		subject.autoCFG.lastSuggestion = null;
		this.autoCFG.inCache = false;
	},

	selection : function(field, start, end)
	{
		if (field.createTextRange) {
			var selRange = field.createTextRange();
			selRange.collapse(true);
			selRange.moveStart("character", start);
			selRange.moveEnd("character", - end + start);
			selRange.select();
		} else if (field.setSelectionRange) {
			field.setSelectionRange(start, end);
		} else {
			if (field.selectionStart) {
				field.selectionStart = start;
				field.selectionEnd = end;
			}
		}
		field.focus();
	},
	
	getSelectionStart : function(field)
	{
		if (field.selectionStart)
			return field.selectionStart;
		else if(field.createTextRange) {
			var selRange = document.selection.createRange();
			var selRange2 = selRange.duplicate();
			return 0 - selRange2.moveStart('character', -100000);
			//result.end = result.start + range.text.length;
			/*var selRange = document.selection.createRange();
			var isCollapsed = selRange.compareEndPoints("StartToEnd", selRange) == 0;
			if (!isCollapsed)
				selRange.collapse(true);
			var bookmark = selRange.getBookmark();
			return bookmark.charCodeAt(2) - 2;*/
		}
	},
	
	getFieldValues : function(field)
	{
		var fieldData = {
			value: field.value,
			pre: '',
			post: '',
			item: ''
		};
		
		if(field.autoCFG.multiple) {
			var finishedPre = false;
			var selectionStart = jQuery.iAuto.getSelectionStart(field)||0;
			var chunks = fieldData.value.split(field.autoCFG.multipleSeparator);
			for (var i=0; i<chunks.length; i++) {
				if(
					(fieldData.pre.length + chunks[i].length >= selectionStart
					 || 
					selectionStart == 0)
					 && 
					!finishedPre 
				) {
					if (fieldData.pre.length <= selectionStart)
						fieldData.item = chunks[i];
					else 
						fieldData.post += chunks[i] + (chunks[i] != '' ? field.autoCFG.multipleSeparator : '');
					finishedPre = true;
				} else if (finishedPre){
					fieldData.post += chunks[i] + (chunks[i] != '' ? field.autoCFG.multipleSeparator : '');
				}
				if(!finishedPre) {
					fieldData.pre += chunks[i] + (chunks.length > 1 ? field.autoCFG.multipleSeparator : '');
				}
			}
		} else {
			fieldData.item = fieldData.value;
		}
		return fieldData;
	},
	
	autocomplete : function(e)
	{
		window.clearTimeout(jQuery.iAuto.timer);
		var subject = jQuery.iAuto.getFieldValues(this);
				
		var pressedKey = e.charCode || e.keyCode || -1;
		if (/13|27|35|36|38|40|9/.test(pressedKey) && jQuery.iAuto.items) {
			if (window.event) {
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			} else {
				e.preventDefault();
				e.stopPropagation();
			}
			if (jQuery.iAuto.selectedItem != null) 
				jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = '';
			else
				jQuery.iAuto.selectedItem = -1;
			switch(pressedKey) {
				//enter
				case 9:
				case 13:
					if (jQuery.iAuto.selectedItem == -1)
						jQuery.iAuto.selectedItem = 0;
					var selectedItem = jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0);
					var valueToAdd = selectedItem.getAttribute('rel');
					this.value = subject.pre + valueToAdd + this.autoCFG.multipleSeparator + subject.post;
					jQuery.iAuto.lastValue = subject.item;
					jQuery.iAuto.selection(
						this, 
						subject.pre.length + valueToAdd.length + this.autoCFG.multipleSeparator.length, 
						subject.pre.length + valueToAdd.length + this.autoCFG.multipleSeparator.length
					);
					jQuery.iAuto.clear();
					if (this.autoCFG.onSelect) {
						iteration = parseInt(selectedItem.getAttribute('dir'))||0;
						jQuery.iAuto.applyOn(this,this.autoCFG.lastSuggestion.get(iteration), 'onSelect');
					}
					if (this.scrollIntoView)
						this.scrollIntoView(false);
					return pressedKey != 13;
					break;
				//escape
				case 27:
					this.value = subject.pre + jQuery.iAuto.lastValue + this.autoCFG.multipleSeparator + subject.post;
					this.autoCFG.lastSuggestion = null;
					jQuery.iAuto.clear();
					if (this.scrollIntoView)
						this.scrollIntoView(false);
					return false;
					break;
				//end
				case 35:
					jQuery.iAuto.selectedItem = jQuery.iAuto.items.size() - 1;
					break;
				//home
				case 36:
					jQuery.iAuto.selectedItem = 0;
					break;
				//up
				case 38:
					jQuery.iAuto.selectedItem --;
					if (jQuery.iAuto.selectedItem < 0)
						jQuery.iAuto.selectedItem = jQuery.iAuto.items.size() - 1;
					break;
				case 40:
					jQuery.iAuto.selectedItem ++;
					if (jQuery.iAuto.selectedItem == jQuery.iAuto.items.size())
						jQuery.iAuto.selectedItem = 0;
					break;
			}
			jQuery.iAuto.applyOn(this,this.autoCFG.lastSuggestion.get(jQuery.iAuto.selectedItem||0), 'onHighlight');
			jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = this.autoCFG.selectClass;
			if (jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).scrollIntoView)
				jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).scrollIntoView(false);
			if(this.autoCFG.autofill) {
				var valToAdd = jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).getAttribute('rel');
				this.value = subject.pre + valToAdd + this.autoCFG.multipleSeparator + subject.post;
				if(jQuery.iAuto.lastValue.length != valToAdd.length)
					jQuery.iAuto.selection(
						this, 
						subject.pre.length + jQuery.iAuto.lastValue.length, 
						subject.pre.length + valToAdd.length
					);
			}
			return false;
		}
		jQuery.iAuto.checkCache.apply(this);
		
		if (this.autoCFG.inCache == false) {
			if (subject.item != jQuery.iAuto.lastValue && subject.item.length >= this.autoCFG.minchars)
				jQuery.iAuto.timer = window.setTimeout(jQuery.iAuto.update, this.autoCFG.delay);
			if (jQuery.iAuto.items) {
				jQuery.iAuto.clear();
			}
		}
		return true;
	},

	applyOn: function(field, item, type)
	{
		if (field.autoCFG[type]) {
			var data = {};
			childs = item.getElementsByTagName('*');
			for(i=0; i<childs.length; i++){
				data[childs[i].tagName] = childs[i].firstChild.nodeValue;
			}
			field.autoCFG[type].apply(field,[data]);
		}
	},
	
	hoverItem : function(e)
	{
		if (jQuery.iAuto.items) {
			if (jQuery.iAuto.selectedItem != null) 
				jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = '';
			jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = '';
			jQuery.iAuto.selectedItem = parseInt(this.getAttribute('dir'))||0;
			jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = jQuery.iAuto.subject.autoCFG.selectClass;
		}
	},

	clickItem : function(event)
	{	
		window.clearTimeout(jQuery.iAuto.timer);
		
		event = event || jQuery.event.fix( window.event );
		event.preventDefault();
		event.stopPropagation();
		var subject = jQuery.iAuto.getFieldValues(jQuery.iAuto.subject);
		var valueToAdd = this.getAttribute('rel');
		jQuery.iAuto.subject.value = subject.pre + valueToAdd + jQuery.iAuto.subject.autoCFG.multipleSeparator + subject.post;
		jQuery.iAuto.lastValue = this.getAttribute('rel');
		jQuery.iAuto.selection(
			jQuery.iAuto.subject, 
			subject.pre.length + valueToAdd.length + jQuery.iAuto.subject.autoCFG.multipleSeparator.length, 
			subject.pre.length + valueToAdd.length + jQuery.iAuto.subject.autoCFG.multipleSeparator.length
		);
		jQuery.iAuto.clear();
		if (jQuery.iAuto.subject.autoCFG.onSelect) {
			iteration = parseInt(this.getAttribute('dir'))||0;
			jQuery.iAuto.applyOn(jQuery.iAuto.subject,jQuery.iAuto.subject.autoCFG.lastSuggestion.get(iteration), 'onSelect');
		}

		return false;
	},

	protect : function(e)
	{
		pressedKey = e.charCode || e.keyCode || -1;
		if (/13|27|35|36|38|40/.test(pressedKey) && jQuery.iAuto.items) {
			if (window.event) {
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			} else {
				e.preventDefault();
				e.stopPropagation();
			}
			return false;
		}
	},

	build : function(options)
	{
		if (!options.source || !jQuery.iUtil) {
			return;
		}

		if (!jQuery.iAuto.helper) {
			if (jQuery.browser.msie) {
				jQuery('body', document).append('<iframe style="display:none;position:absolute;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);" id="autocompleteIframe" src="javascript:false;" frameborder="0" scrolling="no"></iframe>');
				jQuery.iAuto.iframe = jQuery('#autocompleteIframe');
			}
			jQuery('body', document).append('<div id="autocompleteHelper" style="position: absolute; top: 0; left: 0; z-index: 30001; display: none;"><ul style="margin: 0;padding: 0; list-style: none; z-index: 30002;">&nbsp;</ul></div>');
			jQuery.iAuto.helper = jQuery('#autocompleteHelper');
			jQuery.iAuto.content = jQuery('ul', jQuery.iAuto.helper);
		}

		return this.each(
			function()
			{
				if (this.tagName != 'INPUT' && this.getAttribute('type') != 'text' )
					return;
				this.autoCFG = {};
				this.autoCFG.source = options.source;
				this.autoCFG.minchars = Math.abs(parseInt(options.minchars)||1);
				this.autoCFG.helperClass = options.helperClass ? options.helperClass : '';
				this.autoCFG.selectClass = options.selectClass ? options.selectClass : '';
				this.autoCFG.onSelect = options.onSelect && options.onSelect.constructor == Function ? options.onSelect : null;
				this.autoCFG.onShow = options.onShow && options.onShow.constructor == Function ? options.onShow : null;
				this.autoCFG.onHide = options.onHide && options.onHide.constructor == Function ? options.onHide : null;
				this.autoCFG.onHighlight = options.onHighlight && options.onHighlight.constructor == Function ? options.onHighlight : null;
				this.autoCFG.inputWidth = options.inputWidth||false;
				this.autoCFG.multiple = options.multiple||false;
				this.autoCFG.multipleSeparator = this.autoCFG.multiple ? (options.multipleSeparator||', '):'';
				this.autoCFG.autofill = options.autofill ? true : false;
				this.autoCFG.delay = Math.abs(parseInt(options.delay)||1000);
				if (options.fx && options.fx.constructor == Object) {
					if (!options.fx.type || !/fade|slide|blind/.test(options.fx.type)) {
						options.fx.type = 'slide';
					}
					if (options.fx.type == 'slide' && !jQuery.fx.slide)
						return;
					if (options.fx.type == 'blind' && !jQuery.fx.BlindDirection)
						return;

					options.fx.duration = Math.abs(parseInt(options.fx.duration)||400);
					if (options.fx.duration > this.autoCFG.delay) {
						options.fx.duration = this.autoCFG.delay - 100;
					}
					this.autoCFG.fx = options.fx;
				}
				this.autoCFG.lastSuggestion = null;
				this.autoCFG.inCache = false;

				jQuery(this)
					.attr('autocomplete', 'off')
					.focus(
						function()
						{
							jQuery.iAuto.subject = this;
							jQuery.iAuto.lastValue = this.value;
						}
					)
					.keypress(jQuery.iAuto.protect)
					.keyup(jQuery.iAuto.autocomplete)
					
					.blur(
						function()
						{
							jQuery.iAuto.timer = window.setTimeout(jQuery.iAuto.clear, 200);
						}
					);
			}
		);
	}
};
jQuery.fn.Autocomplete = jQuery.iAuto.build;/**
 * Interface Elements for jQuery
 * Autoscroller
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Utility object that helps to make custom autoscrollers.
 * 
 * @example
 *		$('div.dragMe').Draggable(
 *			{
 *				onStart : function()
 *				{
 *					$.iAutoscroller.start(this, document.getElementsByTagName('body'));
 *				},
 *				onStop : function()
 *				{
 *					$.iAutoscroller.stop();
 *				}
 *			}
 *		);
 *
 * @description Utility object that helps to make custom autoscrollers
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */

jQuery.iAutoscroller = {
	timer: null,
	elToScroll: null,
	elsToScroll: null,
	step: 10,
	/**
	 * This is called to start autoscrolling
	 * @param DOMElement el the element used as reference
	 * @param Array els collection of elements to scroll
	 * @param Integer step the pixels scroll on each step
	 * @param Integer interval miliseconds between each step
	 */
	start: function(el, els, step, interval)
	{
		jQuery.iAutoscroller.elToScroll = el;
		jQuery.iAutoscroller.elsToScroll = els;
		jQuery.iAutoscroller.step = parseInt(step)||10;
		jQuery.iAutoscroller.timer = window.setInterval(jQuery.iAutoscroller.doScroll, parseInt(interval)||40);
	},
	
	//private function
	doScroll : function()
	{
		for (i=0;i<jQuery.iAutoscroller.elsToScroll.length; i++) {
				if(!jQuery.iAutoscroller.elsToScroll[i].parentData) {
					jQuery.iAutoscroller.elsToScroll[i].parentData = jQuery.extend(
						jQuery.iUtil.getPositionLite(jQuery.iAutoscroller.elsToScroll[i]),
						jQuery.iUtil.getSizeLite(jQuery.iAutoscroller.elsToScroll[i]),
						jQuery.iUtil.getScroll(jQuery.iAutoscroller.elsToScroll[i])
					);
				} else {
					jQuery.iAutoscroller.elsToScroll[i].parentData.t = jQuery.iAutoscroller.elsToScroll[i].scrollTop;
					jQuery.iAutoscroller.elsToScroll[i].parentData.l = jQuery.iAutoscroller.elsToScroll[i].scrollLeft;
				}
				
				if (jQuery.iAutoscroller.elToScroll.dragCfg && jQuery.iAutoscroller.elToScroll.dragCfg.init == true) {
					elementData = {
						x : jQuery.iAutoscroller.elToScroll.dragCfg.nx,
						y : jQuery.iAutoscroller.elToScroll.dragCfg.ny,
						wb : jQuery.iAutoscroller.elToScroll.dragCfg.oC.wb,
						hb : jQuery.iAutoscroller.elToScroll.dragCfg.oC.hb
					};
				} else {
					elementData = jQuery.extend(
						jQuery.iUtil.getPositionLite(jQuery.iAutoscroller.elToScroll),
						jQuery.iUtil.getSizeLite(jQuery.iAutoscroller.elToScroll)
					);
				}
				if (
					jQuery.iAutoscroller.elsToScroll[i].parentData.t > 0
					 && 
					jQuery.iAutoscroller.elsToScroll[i].parentData.y + jQuery.iAutoscroller.elsToScroll[i].parentData.t > elementData.y) {
					jQuery.iAutoscroller.elsToScroll[i].scrollTop -= jQuery.iAutoscroller.step;
				} else if (jQuery.iAutoscroller.elsToScroll[i].parentData.t <= jQuery.iAutoscroller.elsToScroll[i].parentData.h && jQuery.iAutoscroller.elsToScroll[i].parentData.t + jQuery.iAutoscroller.elsToScroll[i].parentData.hb < elementData.y + elementData.hb) {
					jQuery.iAutoscroller.elsToScroll[i].scrollTop += jQuery.iAutoscroller.step;
				}
				if (jQuery.iAutoscroller.elsToScroll[i].parentData.l > 0 && jQuery.iAutoscroller.elsToScroll[i].parentData.x + jQuery.iAutoscroller.elsToScroll[i].parentData.l > elementData.x) {
					jQuery.iAutoscroller.elsToScroll[i].scrollLeft -= jQuery.iAutoscroller.step;
				} else if (jQuery.iAutoscroller.elsToScroll[i].parentData.l <= jQuery.iAutoscroller.elsToScroll[i].parentData.wh && jQuery.iAutoscroller.elsToScroll[i].parentData.l + jQuery.iAutoscroller.elsToScroll[i].parentData.wb < elementData.x + elementData.wb) {
					jQuery.iAutoscroller.elsToScroll[i].scrollLeft += jQuery.iAutoscroller.step;
				}
		}
	},
	/**
	 * This is called to stop autoscrolling
	 */
	stop: function()
	{
		window.clearInterval(jQuery.iAutoscroller.timer);
		jQuery.iAutoscroller.elToScroll = null;
		jQuery.iAutoscroller.elsToScroll = null;
		for (i in jQuery.iAutoscroller.elsToScroll) {
			jQuery.iAutoscroller.elsToScroll[i].parentData = null;
		}
	}
};/**
 * Interface Elements for jQuery
 * Draggable
 *
 * http://interface.eyecon.ro
 *
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 */
 
/**
 * Create a draggable element with a number of advanced options including callback, Google Maps type draggables,
 * reversion, ghosting, and grid dragging.
 * 
 * @name Draggable
 * @descr Creates draggable elements that can be moved across the page.
 * @param Hash hash A hash of parameters. All parameters are optional.
 * @option String handle (optional) The jQuery selector matching the handle that starts the draggable
 * @option DOMElement handle (optional) The DOM Element of the handle that starts the draggable
 * @option Boolean revert (optional) When true, on stop-drag the element returns to initial position
 * @option Boolean ghosting (optional) When true, a copy of the element is moved
 * @option Integer zIndex (optional) zIndex depth for the element while it is being dragged
 * @option Float opacity (optional) A number between 0 and 1 that indicates the opacity of the element while being dragged
 * @option Integer grid (optional) (optional) A number of pixels indicating the grid that the element should snap to
 * @option Array grid (optional) A number of x-pixels and y-pixels indicating the grid that the element should snap to
 * @option Integer fx (optional) Duration for the effect (like ghosting or revert) applied to the draggable
 * @option String containment (optional) Define the zone where the draggable can be moved. 'parent' moves it inside parent
 *                           element, while 'document' prevents it from leaving the document and forcing additional
 *                           scrolling
 * @option Array containment An 4-element array (left, top, width, height) indicating the containment of the element
 * @option String axis (optional) Set an axis: vertical (with 'vertically') or horizontal (with 'horizontally')
 * @option Function onStart (optional) Callback function triggered when the dragging starts
 * @option Function onStop (optional) Callback function triggered when the dragging stops
 * @option Function onChange (optional) Callback function triggered when the dragging stop *and* the element was moved at least
 *                          one pixel
 * @option Function onDrag (optional) Callback function triggered while the element is dragged. Receives two parameters: x and y
 *                        coordinates. You can return an object with new coordinates {x: x, y: y} so this way you can
 *                        interact with the dragging process (for instance, build your containment)
 * @option Boolean insideParent Forces the element to remain inside its parent when being dragged (like Google Maps)
 * @option Integer snapDistance (optional) The element is not moved unless it is dragged more than snapDistance. You can prevent
 *                             accidental dragging and keep regular clicking enabled (for links or form elements, 
 *                             for instance)
 * @option Object cursorAt (optional) The dragged element is moved to the cursor position with the offset specified. Accepts value
 *                        for top, left, right and bottom offset. Basically, this forces the cursor to a particular
 *                        position during the entire drag operation.
 * @option Boolean autoSize (optional) When true, the drag helper is resized to its content, instead of the dragged element's sizes
 * @option String frameClass (optional) When is set the cloned element is hidden so only a frame is dragged
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */

jQuery.iDrag =	{
	helper : null,
	dragged: null,
	destroy : function()
	{
		return this.each(
			function ()
			{
				if (this.isDraggable) {
					this.dragCfg.dhe.unbind('mousedown', jQuery.iDrag.draginit);
					this.dragCfg = null;
					this.isDraggable = false;
					if(jQuery.browser.msie) {
						this.unselectable = "off";
					} else {
						this.style.MozUserSelect = '';
						this.style.KhtmlUserSelect = '';
						this.style.userSelect = '';
					}
				}
			}
		);
	},
	draginit : function (e)
	{
		if (jQuery.iDrag.dragged != null) {
			jQuery.iDrag.dragstop(e);
			return false;
		}
		var elm = this.dragElem;
		jQuery(document)
			.bind('mousemove', jQuery.iDrag.dragmove)
			.bind('mouseup', jQuery.iDrag.dragstop);
		elm.dragCfg.pointer = jQuery.iUtil.getPointer(e);
		elm.dragCfg.currentPointer = elm.dragCfg.pointer;
		elm.dragCfg.init = false;
		elm.dragCfg.fromHandler = this != this.dragElem;
		jQuery.iDrag.dragged = elm;
		if (elm.dragCfg.si && this != this.dragElem) {
				parentPos = jQuery.iUtil.getPosition(elm.parentNode);
				sliderSize = jQuery.iUtil.getSize(elm);
				sliderPos = {
					x : parseInt(jQuery.css(elm,'left')) || 0,
					y : parseInt(jQuery.css(elm,'top')) || 0
				};
				dx = elm.dragCfg.currentPointer.x - parentPos.x - sliderSize.wb/2 - sliderPos.x;
				dy = elm.dragCfg.currentPointer.y - parentPos.y - sliderSize.hb/2 - sliderPos.y;
				jQuery.iSlider.dragmoveBy(elm, [dx, dy]);
		}
		return jQuery.selectKeyHelper||false;
	},

	dragstart : function(e)
	{
		var elm = jQuery.iDrag.dragged;
		elm.dragCfg.init = true;

		var dEs = elm.style;

		elm.dragCfg.oD = jQuery.css(elm,'display');
		elm.dragCfg.oP = jQuery.css(elm,'position');
		if (!elm.dragCfg.initialPosition)
			elm.dragCfg.initialPosition = elm.dragCfg.oP;

		elm.dragCfg.oR = {
			x : parseInt(jQuery.css(elm,'left')) || 0,
			y : parseInt(jQuery.css(elm,'top')) || 0
		};
		elm.dragCfg.diffX = 0;
		elm.dragCfg.diffY = 0;
		if (jQuery.browser.msie) {
			var oldBorder = jQuery.iUtil.getBorder(elm, true);
			elm.dragCfg.diffX = oldBorder.l||0;
			elm.dragCfg.diffY = oldBorder.t||0;
		}

		elm.dragCfg.oC = jQuery.extend(
			jQuery.iUtil.getPosition(elm),
			jQuery.iUtil.getSize(elm)
		);
		if (elm.dragCfg.oP != 'relative' && elm.dragCfg.oP != 'absolute') {
			dEs.position = 'relative';
		}

		jQuery.iDrag.helper.empty();
		var clonedEl = elm.cloneNode(true);
		
		jQuery(clonedEl).css(
			{
				display:	'block',
				left:		'0px',
				top: 		'0px'
			}
		);
		clonedEl.style.marginTop = '0';
		clonedEl.style.marginRight = '0';
		clonedEl.style.marginBottom = '0';
		clonedEl.style.marginLeft = '0';
		jQuery.iDrag.helper.append(clonedEl);
		
		var dhs = jQuery.iDrag.helper.get(0).style;

		if (elm.dragCfg.autoSize) {
			dhs.width = 'auto';
			dhs.height = 'auto';
		} else {
			dhs.height = elm.dragCfg.oC.hb + 'px';
			dhs.width = elm.dragCfg.oC.wb + 'px';
		}

		dhs.display = 'block';
		dhs.marginTop = '0px';
		dhs.marginRight = '0px';
		dhs.marginBottom = '0px';
		dhs.marginLeft = '0px';

		//remeasure the clone to check if the size was changed by user's functions
		jQuery.extend(
			elm.dragCfg.oC,
			jQuery.iUtil.getSize(clonedEl)
		);

		if (elm.dragCfg.cursorAt) {
			if (elm.dragCfg.cursorAt.left) {
				elm.dragCfg.oR.x += elm.dragCfg.pointer.x - elm.dragCfg.oC.x - elm.dragCfg.cursorAt.left;
				elm.dragCfg.oC.x = elm.dragCfg.pointer.x - elm.dragCfg.cursorAt.left;
			}
			if (elm.dragCfg.cursorAt.top) {
				elm.dragCfg.oR.y += elm.dragCfg.pointer.y - elm.dragCfg.oC.y - elm.dragCfg.cursorAt.top;
				elm.dragCfg.oC.y = elm.dragCfg.pointer.y - elm.dragCfg.cursorAt.top;
			}
			if (elm.dragCfg.cursorAt.right) {
				elm.dragCfg.oR.x += elm.dragCfg.pointer.x - elm.dragCfg.oC.x -elm.dragCfg.oC.hb + elm.dragCfg.cursorAt.right;
				elm.dragCfg.oC.x = elm.dragCfg.pointer.x - elm.dragCfg.oC.wb + elm.dragCfg.cursorAt.right;
			}
			if (elm.dragCfg.cursorAt.bottom) {
				elm.dragCfg.oR.y += elm.dragCfg.pointer.y - elm.dragCfg.oC.y - elm.dragCfg.oC.hb + elm.dragCfg.cursorAt.bottom;
				elm.dragCfg.oC.y = elm.dragCfg.pointer.y - elm.dragCfg.oC.hb + elm.dragCfg.cursorAt.bottom;
			}
		}
		elm.dragCfg.nx = elm.dragCfg.oR.x;
		elm.dragCfg.ny = elm.dragCfg.oR.y;

		if (elm.dragCfg.insideParent || elm.dragCfg.containment == 'parent') {
			parentBorders = jQuery.iUtil.getBorder(elm.parentNode, true);
			elm.dragCfg.oC.x = elm.offsetLeft + (jQuery.browser.msie ? 0 : jQuery.browser.opera ? -parentBorders.l : parentBorders.l);
			elm.dragCfg.oC.y = elm.offsetTop + (jQuery.browser.msie ? 0 : jQuery.browser.opera ? -parentBorders.t : parentBorders.t);
			jQuery(elm.parentNode).append(jQuery.iDrag.helper.get(0));
		}
		if (elm.dragCfg.containment) {
			jQuery.iDrag.getContainment(elm);
			elm.dragCfg.onDragModifier.containment = jQuery.iDrag.fitToContainer;
		}

		if (elm.dragCfg.si) {
			jQuery.iSlider.modifyContainer(elm);
		}

		dhs.left = elm.dragCfg.oC.x - elm.dragCfg.diffX + 'px';
		dhs.top = elm.dragCfg.oC.y - elm.dragCfg.diffY + 'px';
		//resize the helper to fit the clone
		dhs.width = elm.dragCfg.oC.wb + 'px';
		dhs.height = elm.dragCfg.oC.hb + 'px';

		jQuery.iDrag.dragged.dragCfg.prot = false;

		if (elm.dragCfg.gx) {
			elm.dragCfg.onDragModifier.grid = jQuery.iDrag.snapToGrid;
		}
		if (elm.dragCfg.zIndex != false) {
			jQuery.iDrag.helper.css('zIndex', elm.dragCfg.zIndex);
		}
		if (elm.dragCfg.opacity) {
			jQuery.iDrag.helper.css('opacity', elm.dragCfg.opacity);
			if (window.ActiveXObject) {
				jQuery.iDrag.helper.css('filter', 'alpha(opacity=' + elm.dragCfg.opacity * 100 + ')');
			}
		}

		if(elm.dragCfg.frameClass) {
			jQuery.iDrag.helper.addClass(elm.dragCfg.frameClass);
			jQuery.iDrag.helper.get(0).firstChild.style.display = 'none';
		}
		if (elm.dragCfg.onStart)
			elm.dragCfg.onStart.apply(elm, [clonedEl, elm.dragCfg.oR.x, elm.dragCfg.oR.y]);
		if (jQuery.iDrop && jQuery.iDrop.count > 0 ){
			jQuery.iDrop.highlight(elm);
		}
		if (elm.dragCfg.ghosting == false) {
			dEs.display = 'none';
		}
		return false;
	},

	getContainment : function(elm)
	{
		if (elm.dragCfg.containment.constructor == String) {
			if (elm.dragCfg.containment == 'parent') {
				elm.dragCfg.cont = jQuery.extend(
					{x:0,y:0},
					jQuery.iUtil.getSize(elm.parentNode)
				);
				var contBorders = jQuery.iUtil.getBorder(elm.parentNode, true);
				elm.dragCfg.cont.w = elm.dragCfg.cont.wb - contBorders.l - contBorders.r;
				elm.dragCfg.cont.h = elm.dragCfg.cont.hb - contBorders.t - contBorders.b;
			} else if (elm.dragCfg.containment == 'document') {
				var clnt = jQuery.iUtil.getClient();
				elm.dragCfg.cont = {
					x : 0,
					y : 0,
					w : clnt.w,
					h : clnt.h
				};
			}
		} else if (elm.dragCfg.containment.constructor == Array) {
			elm.dragCfg.cont = {
				x : parseInt(elm.dragCfg.containment[0])||0,
				y : parseInt(elm.dragCfg.containment[1])||0,
				w : parseInt(elm.dragCfg.containment[2])||0,
				h : parseInt(elm.dragCfg.containment[3])||0
			};
		}
		elm.dragCfg.cont.dx = elm.dragCfg.cont.x - elm.dragCfg.oC.x;
		elm.dragCfg.cont.dy = elm.dragCfg.cont.y - elm.dragCfg.oC.y;
	},

	hidehelper : function(dragged)
	{
		if (dragged.dragCfg.insideParent || dragged.dragCfg.containment == 'parent') {
			jQuery('body', document).append(jQuery.iDrag.helper.get(0));
		}
		jQuery.iDrag.helper.empty().hide().css('opacity', 1);
		if (window.ActiveXObject) {
			jQuery.iDrag.helper.css('filter', 'alpha(opacity=100)');
		}
	},

	dragstop : function(e)
	{

		jQuery(document)
			.unbind('mousemove', jQuery.iDrag.dragmove)
			.unbind('mouseup', jQuery.iDrag.dragstop);

		if (jQuery.iDrag.dragged == null) {
			return;
		}
		var dragged = jQuery.iDrag.dragged;

		jQuery.iDrag.dragged = null;

		if (dragged.dragCfg.init == false) {
			return false;
		}
		if (dragged.dragCfg.so == true) {
			jQuery(dragged).css('position', dragged.dragCfg.oP);
		}
		var dEs = dragged.style;

		if (dragged.si) {
			jQuery.iDrag.helper.css('cursor', 'move');
		}
		if(dragged.dragCfg.frameClass) {
			jQuery.iDrag.helper.removeClass(dragged.dragCfg.frameClass);
		}

		if (dragged.dragCfg.revert == false) {
			if (dragged.dragCfg.fx > 0) {
				if (!dragged.dragCfg.axis || dragged.dragCfg.axis == 'horizontally') {
					var x = new jQuery.fx(dragged,{duration:dragged.dragCfg.fx}, 'left');
					x.custom(dragged.dragCfg.oR.x,dragged.dragCfg.nRx);
				}
				if (!dragged.dragCfg.axis || dragged.dragCfg.axis == 'vertically') {
					var y = new jQuery.fx(dragged,{duration:dragged.dragCfg.fx}, 'top');
					y.custom(dragged.dragCfg.oR.y,dragged.dragCfg.nRy);
				}
			} else {
				if (!dragged.dragCfg.axis || dragged.dragCfg.axis == 'horizontally')
					dragged.style.left = dragged.dragCfg.nRx + 'px';
				if (!dragged.dragCfg.axis || dragged.dragCfg.axis == 'vertically')
					dragged.style.top = dragged.dragCfg.nRy + 'px';
			}
			jQuery.iDrag.hidehelper(dragged);
			if (dragged.dragCfg.ghosting == false) {
				jQuery(dragged).css('display', dragged.dragCfg.oD);
			}
		} else if (dragged.dragCfg.fx > 0) {
			dragged.dragCfg.prot = true;
			var dh = false;
			if(jQuery.iDrop && jQuery.iSort && dragged.dragCfg.so) {
				dh = jQuery.iUtil.getPosition(jQuery.iSort.helper.get(0));
			}
			jQuery.iDrag.helper.animate(
				{
					left : dh ? dh.x : dragged.dragCfg.oC.x,
					top : dh ? dh.y : dragged.dragCfg.oC.y
				},
				dragged.dragCfg.fx,
				function()
				{
					dragged.dragCfg.prot = false;
					if (dragged.dragCfg.ghosting == false) {
						dragged.style.display = dragged.dragCfg.oD;
					}
					jQuery.iDrag.hidehelper(dragged);
				}
			);
		} else {
			jQuery.iDrag.hidehelper(dragged);
			if (dragged.dragCfg.ghosting == false) {
				jQuery(dragged).css('display', dragged.dragCfg.oD);
			}
		}

		if (jQuery.iDrop && jQuery.iDrop.count > 0 ){
			jQuery.iDrop.checkdrop(dragged);
		}
		if (jQuery.iSort && dragged.dragCfg.so) {
			jQuery.iSort.check(dragged);
		}
		if (dragged.dragCfg.onChange && (dragged.dragCfg.nRx != dragged.dragCfg.oR.x || dragged.dragCfg.nRy != dragged.dragCfg.oR.y)){
			dragged.dragCfg.onChange.apply(dragged, dragged.dragCfg.lastSi||[0,0,dragged.dragCfg.nRx,dragged.dragCfg.nRy]);
		}
		if (dragged.dragCfg.onStop)
			dragged.dragCfg.onStop.apply(dragged);
		return false;
	},

	snapToGrid : function(x, y, dx, dy)
	{
		if (dx != 0)
			dx = parseInt((dx + (this.dragCfg.gx * dx/Math.abs(dx))/2)/this.dragCfg.gx) * this.dragCfg.gx;
		if (dy != 0)
			dy = parseInt((dy + (this.dragCfg.gy * dy/Math.abs(dy))/2)/this.dragCfg.gy) * this.dragCfg.gy;
		return {
			dx : dx,
			dy : dy,
			x: 0,
			y: 0
		};
	},

	fitToContainer : function(x, y, dx, dy)
	{
		dx = Math.min(
				Math.max(dx,this.dragCfg.cont.dx),
				this.dragCfg.cont.w + this.dragCfg.cont.dx - this.dragCfg.oC.wb
			);
		dy = Math.min(
				Math.max(dy,this.dragCfg.cont.dy),
				this.dragCfg.cont.h + this.dragCfg.cont.dy - this.dragCfg.oC.hb
			);

		return {
			dx : dx,
			dy : dy,
			x: 0,
			y: 0
		}
	},

	dragmove : function(e)
	{
		if (jQuery.iDrag.dragged == null || jQuery.iDrag.dragged.dragCfg.prot == true) {
			return;
		}

		var dragged = jQuery.iDrag.dragged;

		dragged.dragCfg.currentPointer = jQuery.iUtil.getPointer(e);
		if (dragged.dragCfg.init == false) {
			distance = Math.sqrt(Math.pow(dragged.dragCfg.pointer.x - dragged.dragCfg.currentPointer.x, 2) + Math.pow(dragged.dragCfg.pointer.y - dragged.dragCfg.currentPointer.y, 2));
			if (distance < dragged.dragCfg.snapDistance){
				return;
			} else {
				jQuery.iDrag.dragstart(e);
			}
		}

		var dx = dragged.dragCfg.currentPointer.x - dragged.dragCfg.pointer.x;
		var dy = dragged.dragCfg.currentPointer.y - dragged.dragCfg.pointer.y;

		for (var i in dragged.dragCfg.onDragModifier) {
			var newCoords = dragged.dragCfg.onDragModifier[i].apply(dragged, [dragged.dragCfg.oR.x + dx, dragged.dragCfg.oR.y + dy, dx, dy]);
			if (newCoords && newCoords.constructor == Object) {
				dx = i != 'user' ? newCoords.dx : (newCoords.x - dragged.dragCfg.oR.x);
				dy = i != 'user' ? newCoords.dy : (newCoords.y - dragged.dragCfg.oR.y);
			}
		}

		dragged.dragCfg.nx = dragged.dragCfg.oC.x + dx - dragged.dragCfg.diffX;
		dragged.dragCfg.ny = dragged.dragCfg.oC.y + dy - dragged.dragCfg.diffY;

		if (dragged.dragCfg.si && (dragged.dragCfg.onSlide || dragged.dragCfg.onChange)) {
			jQuery.iSlider.onSlide(dragged, dragged.dragCfg.nx, dragged.dragCfg.ny);
		}

		if(dragged.dragCfg.onDrag)
			dragged.dragCfg.onDrag.apply(dragged, [dragged.dragCfg.oR.x + dx, dragged.dragCfg.oR.y + dy]);
			
		if (!dragged.dragCfg.axis || dragged.dragCfg.axis == 'horizontally') {
			dragged.dragCfg.nRx = dragged.dragCfg.oR.x + dx;
			jQuery.iDrag.helper.get(0).style.left = dragged.dragCfg.nx + 'px';
		}
		if (!dragged.dragCfg.axis || dragged.dragCfg.axis == 'vertically') {
			dragged.dragCfg.nRy = dragged.dragCfg.oR.y + dy;
			jQuery.iDrag.helper.get(0).style.top = dragged.dragCfg.ny + 'px';
		}
		
		if (jQuery.iDrop && jQuery.iDrop.count > 0 ){
			jQuery.iDrop.checkhover(dragged);
		}
		return false;
	},

	build : function(o)
	{
		if (!jQuery.iDrag.helper) {
			jQuery('body',document).append('<div id="dragHelper"></div>');
			jQuery.iDrag.helper = jQuery('#dragHelper');
			var el = jQuery.iDrag.helper.get(0);
			var els = el.style;
			els.position = 'absolute';
			els.display = 'none';
			els.cursor = 'move';
			els.listStyle = 'none';
			els.overflow = 'hidden';
			if (window.ActiveXObject) {
				el.unselectable = "on";
			} else {
				els.mozUserSelect = 'none';
				els.userSelect = 'none';
				els.KhtmlUserSelect = 'none';
			}
		}
		if (!o) {
			o = {};
		}
		return this.each(
			function()
			{
				if (this.isDraggable || !jQuery.iUtil)
					return;
				if (window.ActiveXObject) {
					this.onselectstart = function(){return false;};
					this.ondragstart = function(){return false;};
				}
				var el = this;
				var dhe = o.handle ? jQuery(this).find(o.handle) : jQuery(this);
				if(jQuery.browser.msie) {
					dhe.each(
						function()
						{
							this.unselectable = "on";
						}
					);
				} else {
					dhe.css('-moz-user-select', 'none');
					dhe.css('user-select', 'none');
					dhe.css('-khtml-user-select', 'none');
				}
				this.dragCfg = {
					dhe: dhe,
					revert : o.revert ? true : false,
					ghosting : o.ghosting ? true : false,
					so : o.so ? o.so : false,
					si : o.si ? o.si : false,
					insideParent : o.insideParent ? o.insideParent : false,
					zIndex : o.zIndex ? parseInt(o.zIndex)||0 : false,
					opacity : o.opacity ? parseFloat(o.opacity) : false,
					fx : parseInt(o.fx)||null,
					hpc : o.hpc ? o.hpc : false,
					onDragModifier : {},
					pointer : {},
					onStart : o.onStart && o.onStart.constructor == Function ? o.onStart : false,
					onStop : o.onStop && o.onStop.constructor == Function ? o.onStop : false,
					onChange : o.onChange && o.onChange.constructor == Function ? o.onChange : false,
					axis : /vertically|horizontally/.test(o.axis) ? o.axis : false,
					snapDistance : o.snapDistance ? parseInt(o.snapDistance)||0 : 0,
					cursorAt: o.cursorAt ? o.cursorAt : false,
					autoSize : o.autoSize ? true : false,
					frameClass : o.frameClass || false
					
				};
				if (o.onDragModifier && o.onDragModifier.constructor == Function)
					this.dragCfg.onDragModifier.user = o.onDragModifier;
				if (o.onDrag && o.onDrag.constructor == Function)
					this.dragCfg.onDrag = o.onDrag;
				if (o.containment && ((o.containment.constructor == String && (o.containment == 'parent' || o.containment == 'document')) || (o.containment.constructor == Array && o.containment.length == 4) )) {
					this.dragCfg.containment = o.containment;
				}
				if(o.fractions) {
					this.dragCfg.fractions = o.fractions;
				}
				if(o.grid){
					if(typeof o.grid == 'number'){
						this.dragCfg.gx = parseInt(o.grid)||1;
						this.dragCfg.gy = parseInt(o.grid)||1;
					} else if (o.grid.length == 2) {
						this.dragCfg.gx = parseInt(o.grid[0])||1;
						this.dragCfg.gy = parseInt(o.grid[1])||1;
					}
				}
				if (o.onSlide && o.onSlide.constructor == Function) {
					this.dragCfg.onSlide = o.onSlide;
				}

				this.isDraggable = true;
				dhe.each(
					function(){
						this.dragElem = el;
					}
				);
				dhe.bind('mousedown', jQuery.iDrag.draginit);
			}
		)
	}
};

/**
 * Destroy an existing draggable on a collection of elements
 * 
 * @name DraggableDestroy
 * @descr Destroy a draggable
 * @type jQuery
 * @cat Plugins/Interface
 * @example $('#drag2').DraggableDestroy();
 */

jQuery.fn.extend(
	{
		DraggableDestroy : jQuery.iDrag.destroy,
		Draggable : jQuery.iDrag.build
	}
);/**
 * Interface Elements for jQuery
 * Droppables
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * With the Draggables plugin, Droppable allows you to create drop zones for draggable elements.
 *
 * @name Droppable
 * @cat Plugins/Interface
 * @param Hash options A hash of options
 * @option String accept The class name for draggables to get accepted by the droppable (mandatory)
 * @option String activeclass When an acceptable draggable is moved, the droppable gets this class
 * @option String hoverclass When an acceptable draggable is inside the droppable, the droppable gets
 *                           this class
 * @option String tolerance  Choose from 'pointer', 'intersect', or 'fit'. The pointer options means
 *                           that the pointer must be inside the droppable in order for the draggable
 *                           to be dropped. The intersect option means that the draggable must intersect
 *                           the droppable. The fit option means that the entire draggable must be
 *                           inside the droppable.
 * @option Function onDrop   When an acceptable draggable is dropped on a droppable, this callback is
 *                           called. It passes the draggable DOMElement as a parameter.
 * @option Function onHover  When an acceptable draggable is hovered over a droppable, this callback
 *                           is called. It passes the draggable DOMElement as a parameter.
 * @option Function onOut    When an acceptable draggable leaves a droppable, this callback is called.
 *                           It passes the draggable DOMElement as a parameter.
 * @example                  $('#dropzone1').Droppable(
 *                             {
 *                               accept : 'dropaccept', 
 *                               activeclass: 'dropzoneactive', 
 *                               hoverclass:	'dropzonehover',
 *                               ondrop:	function (drag) {
 *                                              alert(this); //the droppable
 *                                              alert(drag); //the draggable
 *                                        },
 *                               fit: true
 *                             }
 *                           )
 */

jQuery.iDrop = {
	fit : function (zonex, zoney, zonew, zoneh)
	{
		return 	zonex <= jQuery.iDrag.dragged.dragCfg.nx && 
				(zonex + zonew) >= (jQuery.iDrag.dragged.dragCfg.nx + jQuery.iDrag.dragged.dragCfg.oC.w) &&
				zoney <= jQuery.iDrag.dragged.dragCfg.ny && 
				(zoney + zoneh) >= (jQuery.iDrag.dragged.dragCfg.ny + jQuery.iDrag.dragged.dragCfg.oC.h) ? true :false;
	},
	intersect : function (zonex, zoney, zonew, zoneh)
	{
		return 	! ( zonex > (jQuery.iDrag.dragged.dragCfg.nx + jQuery.iDrag.dragged.dragCfg.oC.w)
				|| (zonex + zonew) < jQuery.iDrag.dragged.dragCfg.nx 
				|| zoney > (jQuery.iDrag.dragged.dragCfg.ny + jQuery.iDrag.dragged.dragCfg.oC.h) 
				|| (zoney + zoneh) < jQuery.iDrag.dragged.dragCfg.ny
				) ? true :false;
	},
	pointer : function (zonex, zoney, zonew, zoneh)
	{
		return	zonex < jQuery.iDrag.dragged.dragCfg.currentPointer.x
				&& (zonex + zonew) > jQuery.iDrag.dragged.dragCfg.currentPointer.x 
				&& zoney < jQuery.iDrag.dragged.dragCfg.currentPointer.y 
				&& (zoney + zoneh) > jQuery.iDrag.dragged.dragCfg.currentPointer.y
				? true :false;
	},
	overzone : false,
	highlighted : {},
	count : 0,
	zones : {},
	
	highlight : function (elm)
	{
		if (jQuery.iDrag.dragged == null) {
			return;
		}
		var i;
		jQuery.iDrop.highlighted = {};
		var oneIsSortable = false;
		for (i in jQuery.iDrop.zones) {
			if (jQuery.iDrop.zones[i] != null) {
				var iEL = jQuery.iDrop.zones[i].get(0);
				if (jQuery(jQuery.iDrag.dragged).is('.' + iEL.dropCfg.a)) {
					if (iEL.dropCfg.m == false) {
						iEL.dropCfg.p = jQuery.extend(
							jQuery.iUtil.getPositionLite(iEL),
							jQuery.iUtil.getSizeLite(iEL)
						);//jQuery.iUtil.getPos(iEL);
						iEL.dropCfg.m = true;
					}
					if (iEL.dropCfg.ac) {
						jQuery.iDrop.zones[i].addClass(iEL.dropCfg.ac);
					}
					jQuery.iDrop.highlighted[i] = jQuery.iDrop.zones[i];
					//if (jQuery.iSort && jQuery.iDrag.dragged.dragCfg.so) {
					if (jQuery.iSort && iEL.dropCfg.s && jQuery.iDrag.dragged.dragCfg.so) {
						iEL.dropCfg.el = jQuery('.' + iEL.dropCfg.a, iEL);
						elm.style.display = 'none';
						jQuery.iSort.measure(iEL);
						iEL.dropCfg.os = jQuery.iSort.serialize(jQuery.attr(iEL, 'id')).hash;
						elm.style.display = elm.dragCfg.oD;
						oneIsSortable = true;
					}
					if (iEL.dropCfg.onActivate) {
						iEL.dropCfg.onActivate.apply(jQuery.iDrop.zones[i].get(0), [jQuery.iDrag.dragged]);
					}
				}
			}
		}
		//if (jQuery.iSort && jQuery.iDrag.dragged.dragCfg.so) {
		if (oneIsSortable) {
			jQuery.iSort.start();
		}
	},
	/**
	 * remeasure the droppable
	 * 
	 * useful when the positions/dimensions for droppables 
	 * are changed while dragging a element
	 * 
	 * this works for sortables too but with a greate processor 
	 * penality because remeasures each sort items too
	 */
	remeasure : function()
	{
		jQuery.iDrop.highlighted = {};
		for (i in jQuery.iDrop.zones) {
			if (jQuery.iDrop.zones[i] != null) {
				var iEL = jQuery.iDrop.zones[i].get(0);
				if (jQuery(jQuery.iDrag.dragged).is('.' + iEL.dropCfg.a)) {
					iEL.dropCfg.p = jQuery.extend(
						jQuery.iUtil.getPositionLite(iEL),
						jQuery.iUtil.getSizeLite(iEL)
					);
					if (iEL.dropCfg.ac) {
						jQuery.iDrop.zones[i].addClass(iEL.dropCfg.ac);
					}
					jQuery.iDrop.highlighted[i] = jQuery.iDrop.zones[i];
					
					if (jQuery.iSort && iEL.dropCfg.s && jQuery.iDrag.dragged.dragCfg.so) {
						iEL.dropCfg.el = jQuery('.' + iEL.dropCfg.a, iEL);
						elm.style.display = 'none';
						jQuery.iSort.measure(iEL);
						elm.style.display = elm.dragCfg.oD;
					}
				}
			}
		}
	},
	
	checkhover : function (e)
	{
		if (jQuery.iDrag.dragged == null) {
			return;
		}
		jQuery.iDrop.overzone = false;
		var i;
		var applyOnHover = false;
		var hlt = 0;
		for (i in jQuery.iDrop.highlighted)
		{
			var iEL = jQuery.iDrop.highlighted[i].get(0);
			if ( 
					jQuery.iDrop.overzone == false
					 && 
					jQuery.iDrop[iEL.dropCfg.t](
					 	iEL.dropCfg.p.x, 
						iEL.dropCfg.p.y, 
						iEL.dropCfg.p.wb, 
						iEL.dropCfg.p.hb
					)
					 
			) {
				if (iEL.dropCfg.hc && iEL.dropCfg.h == false) {
					jQuery.iDrop.highlighted[i].addClass(iEL.dropCfg.hc);
				}
				//chec if onHover function has to be called
				if (iEL.dropCfg.h == false &&iEL.dropCfg.onHover) {
					applyOnHover = true;
				}
				iEL.dropCfg.h = true;
				jQuery.iDrop.overzone = iEL;
				//if(jQuery.iSort && jQuery.iDrag.dragged.dragCfg.so) {
				if(jQuery.iSort && iEL.dropCfg.s && jQuery.iDrag.dragged.dragCfg.so) {
					jQuery.iSort.helper.get(0).className = iEL.dropCfg.shc;
					jQuery.iSort.checkhover(iEL);
				}
				hlt ++;
			} else if(iEL.dropCfg.h == true) {
				//onOut function
				if (iEL.dropCfg.onOut) {
					iEL.dropCfg.onOut.apply(iEL, [e, jQuery.iDrag.helper.get(0).firstChild, iEL.dropCfg.fx]);
				}
				if (iEL.dropCfg.hc) {
					jQuery.iDrop.highlighted[i].removeClass(iEL.dropCfg.hc);
				}
				iEL.dropCfg.h = false;
			}
		}
		if (jQuery.iSort && !jQuery.iDrop.overzone && jQuery.iDrag.dragged.so) {
			jQuery.iSort.helper.get(0).style.display = 'none';
			//jQuery('body').append(jQuery.iSort.helper.get(0));
		}
		//call onhover
		if(applyOnHover) {
			jQuery.iDrop.overzone.dropCfg.onHover.apply(jQuery.iDrop.overzone, [e, jQuery.iDrag.helper.get(0).firstChild]);
		}
	},
	checkdrop : function (e)
	{
		var i;
		for (i in jQuery.iDrop.highlighted) {
			var iEL = jQuery.iDrop.highlighted[i].get(0);
			if (iEL.dropCfg.ac) {
				jQuery.iDrop.highlighted[i].removeClass(iEL.dropCfg.ac);
			}
			if (iEL.dropCfg.hc) {
				jQuery.iDrop.highlighted[i].removeClass(iEL.dropCfg.hc);
			}
			if(iEL.dropCfg.s) {
				jQuery.iSort.changed[jQuery.iSort.changed.length] = i;
			}
			if (iEL.dropCfg.onDrop && iEL.dropCfg.h == true) {
				iEL.dropCfg.h = false;
				iEL.dropCfg.onDrop.apply(iEL, [e, iEL.dropCfg.fx]);
			}
			iEL.dropCfg.m = false;
			iEL.dropCfg.h  = false;
		}
		jQuery.iDrop.highlighted = {};
	},
	destroy : function()
	{
		return this.each(
			function()
			{
				if (this.isDroppable) {
					if (this.dropCfg.s) {
						id = jQuery.attr(this,'id');
						jQuery.iSort.collected[id] = null;
						jQuery('.' + this.dropCfg.a, this).DraggableDestroy();
					}
					jQuery.iDrop.zones['d' + this.idsa] = null;
					this.isDroppable = false;
					this.f = null;
				}
			}
		);
	},
	build : function (o)
	{
		return this.each(
			function()
			{
				if (this.isDroppable == true || !o.accept || !jQuery.iUtil || !jQuery.iDrag){
					return;
				}
				this.dropCfg = {
					a : o.accept,
					ac: o.activeclass||false, 
					hc:	o.hoverclass||false,
					shc: o.helperclass||false,
					onDrop:	o.ondrop||o.onDrop||false,
					onHover: o.onHover||o.onhover||false,
					onOut: o.onOut||o.onout||false,
					onActivate: o.onActivate||false,
					t: o.tolerance && ( o.tolerance == 'fit' || o.tolerance == 'intersect') ? o.tolerance : 'pointer',
					fx: o.fx ? o.fx : false,
					m: false,
					h: false
				};
				if (o.sortable == true && jQuery.iSort) {
					id = jQuery.attr(this,'id');
					jQuery.iSort.collected[id] = this.dropCfg.a;
					this.dropCfg.s = true;
					if(o.onChange) {
						this.dropCfg.onChange = o.onChange;
						this.dropCfg.os = jQuery.iSort.serialize(id).hash;
					}
				}
				this.isDroppable = true;
				this.idsa = parseInt(Math.random() * 10000);
				jQuery.iDrop.zones['d' + this.idsa] = jQuery(this);
				jQuery.iDrop.count ++;
			}
		);
	}
};

/**
 * Destroy an existing droppable on a collection of elements
 * 
 * @name DroppableDestroy
 * @descr Destroy a droppable
 * @type jQuery
 * @cat Plugins/Interface
 * @example $('#drag2').DroppableDestroy();
 */

jQuery.fn.extend(
	{
		DroppableDestroy : jQuery.iDrop.destroy,
		Droppable : jQuery.iDrop.build
	}
);

 
/**
 * Recalculate all Droppables
 *
 * @name $.recallDroppables
 * @type jQuery
 * @cat Plugins/Interface
 * @example $.recallDroppable();
 */

jQuery.recallDroppables = jQuery.iDrop.remeasure;/**
 * Interface Elements for jQuery
 * Expander
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */
 
/**
 * Expands text and textarea elements while new characters are typed to the a miximum width
 *
 * @name Expander
 * @description Expands text and textarea elements while new characters are typed to the a miximum width
 * @param Mixed limit integer if only expands in width, array if expands in width and height
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */

jQuery.iExpander =
{
	helper : null,
	expand : function()
	{
		
		text = this.value;
		if (!text)
			return;
		style = {
			fontFamily: jQuery(this).css('fontFamily')||'',
			fontSize: jQuery(this).css('fontSize')||'',
			fontWeight: jQuery(this).css('fontWeight')||'',
			fontStyle: jQuery(this).css('fontStyle')||'',
			fontStretch: jQuery(this).css('fontStretch')||'',
			fontVariant: jQuery(this).css('fontVariant')||'',
			letterSpacing: jQuery(this).css('letterSpacing')||'',
			wordSpacing: jQuery(this).css('wordSpacing')||''
		};
		jQuery.iExpander.helper.css(style);
		html = jQuery.iExpander.htmlEntities(text);
		html = html.replace(new RegExp( "\\n", "g" ), "<br />");
		jQuery.iExpander.helper.html('pW');
		spacer = jQuery.iExpander.helper.get(0).offsetWidth;
		jQuery.iExpander.helper.html(html);
		width = jQuery.iExpander.helper.get(0).offsetWidth + spacer;
		if (this.Expander.limit && width > this.Expander.limit[0]) {
			width = this.Expander.limit[0];
		}
		this.style.width = width + 'px';
		if (this.tagName == 'TEXTAREA') {
			height = jQuery.iExpander.helper.get(0).offsetHeight + spacer;
			if (this.Expander.limit && height > this.Expander.limit[1]) {
				height = this.Expander.limit[1];
			}
			this.style.height = height + 'px';
		}
	},
	htmlEntities : function(text)
	{ 
		entities = {
			'&':'&amp;',
			'<':'&lt;',
			'>':'&gt;',
			'"':'&quot;'
		};
		for(i in entities) {
			text = text.replace(new RegExp(i,'g'),entities[i]);
		}
		return text;
	},
	build : function(limit)
	{
		if (jQuery.iExpander.helper == null) {
			jQuery('body', document).append('<div id="expanderHelper" style="position: absolute; top: 0; left: 0; visibility: hidden;"></div>');
			jQuery.iExpander.helper = jQuery('#expanderHelper');
		}
		return this.each(
			function()
			{
				if (/TEXTAREA|INPUT/.test(this.tagName)) {
					if (this.tagName == 'INPUT') {
						elType = this.getAttribute('type');
						if (!/text|password/.test(elType)) {
							return;
						}
					}
					if (limit && (limit.constructor == Number || (limit.constructor == Array && limit.length == 2))) {
						if (limit.constructor == Number)
							limit = [limit, limit];
						else {
							limit[0] = parseInt(limit[0])||400;
							limit[1] = parseInt(limit[1])||400;
						}
						this.Expander = {
							limit : limit
						};
					}
					jQuery(this)
						.blur(jQuery.iExpander.expand)
						.keyup(jQuery.iExpander.expand)
						.keypress(jQuery.iExpander.expand);
					jQuery.iExpander.expand.apply(this);
				}
			}
		);			
	}
};

jQuery.fn.Autoexpand = jQuery.iExpander.build;/**
 * Interface Elements for jQuery
 * FX
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Validates elements that can be animated
 */
jQuery.fxCheckTag = function(e)
{
	if (/^tr$|^td$|^tbody$|^caption$|^thead$|^tfoot$|^col$|^colgroup$|^th$|^body$|^header$|^script$|^frame$|^frameset$|^option$|^optgroup$|^meta$/i.test(e.nodeName) )
		return false;
	else 
		return true;
};

/**
 * Destroy the wrapper used for some animations
 */
jQuery.fx.destroyWrapper = function(e, old)
{
	var c = e.firstChild;
	var cs = c.style;
	cs.position = old.position;
	cs.marginTop = old.margins.t;
	cs.marginLeft = old.margins.l;
	cs.marginBottom = old.margins.b;
	cs.marginRight = old.margins.r;
	cs.top = old.top + 'px';
	cs.left = old.left + 'px';
	e.parentNode.insertBefore(c, e);
	e.parentNode.removeChild(e);
};

/**
 * Builds a wrapper used for some animations
 */
jQuery.fx.buildWrapper = function(e)
{
	if (!jQuery.fxCheckTag(e))
		return false;
	var t = jQuery(e);
	var es = e.style;
	var restoreStyle = false;
	
	if (t.css('display') == 'none') {
		oldVisibility = t.css('visibility');
		t.css('visibility', 'hidden').show();
		restoreStyle = true;
	}
	var oldStyle = {};
	oldStyle.position = t.css('position');
	oldStyle.sizes = jQuery.iUtil.getSize(e);
	oldStyle.margins = jQuery.iUtil.getMargins(e);
	
	var oldFloat = e.currentStyle ? e.currentStyle.styleFloat : t.css('float');
	oldStyle.top = parseInt(t.css('top'))||0;
	oldStyle.left = parseInt(t.css('left'))||0;
	var wid = 'w_' + parseInt(Math.random() * 10000);
	var wr = document.createElement(/^img$|^br$|^input$|^hr$|^select$|^textarea$|^object$|^iframe$|^button$|^form$|^table$|^ul$|^dl$|^ol$/i.test(e.nodeName) ? 'div' : e.nodeName);
	jQuery.attr(wr,'id', wid);
	var wrapEl = jQuery(wr).addClass('fxWrapper');
	var wrs = wr.style;
	var top = 0;
	var left = 0;
	if (oldStyle.position == 'relative' || oldStyle.position == 'absolute'){
		top = oldStyle.top;
		left = oldStyle.left;
	}
	
	wrs.top = top + 'px';
	wrs.left = left + 'px';
	wrs.position = oldStyle.position != 'relative' && oldStyle.position != 'absolute' ? 'relative' : oldStyle.position;
	wrs.height = oldStyle.sizes.hb + 'px';
	wrs.width = oldStyle.sizes.wb + 'px';
	wrs.marginTop = oldStyle.margins.t;
	wrs.marginRight = oldStyle.margins.r;
	wrs.marginBottom = oldStyle.margins.b;
	wrs.marginLeft = oldStyle.margins.l;
	wrs.overflow = 'hidden';
	if (jQuery.browser.msie) {
		wrs.styleFloat = oldFloat;
	} else {
		wrs.cssFloat = oldFloat;
	}
	if (jQuery.browser == "msie") {
		es.filter = "alpha(opacity=" + 0.999*100 + ")";
	}
	es.opacity = 0.999;
	//t.wrap(wr);
	e.parentNode.insertBefore(wr, e);
	wr.appendChild(e);
	es.marginTop = '0px';
	es.marginRight = '0px';
	es.marginBottom = '0px';
	es.marginLeft = '0px';
	es.position = 'absolute';
	es.listStyle = 'none';
	es.top = '0px';
	es.left = '0px';
	if (restoreStyle) {
		t.hide();
		es.visibility = oldVisibility;
	}
	return {oldStyle:oldStyle, wrapper:jQuery(wr)};
};

/**
 * named colors
 */
jQuery.fx.namedColors = {
	aqua:[0,255,255],
	azure:[240,255,255],
	beige:[245,245,220],
	black:[0,0,0],
	blue:[0,0,255],
	brown:[165,42,42],
	cyan:[0,255,255],
	darkblue:[0,0,139],
	darkcyan:[0,139,139],
	darkgrey:[169,169,169],
	darkgreen:[0,100,0],
	darkkhaki:[189,183,107],
	darkmagenta:[139,0,139],
	darkolivegreen:[85,107,47],
	darkorange:[255,140,0],
	darkorchid:[153,50,204],
	darkred:[139,0,0],
	darksalmon:[233,150,122],
	darkviolet:[148,0,211],
	fuchsia:[255,0,255],
	gold:[255,215,0],
	green:[0,128,0],
	indigo:[75,0,130],
	khaki:[240,230,140],
	lightblue:[173,216,230],
	lightcyan:[224,255,255],
	lightgreen:[144,238,144],
	lightgrey:[211,211,211],
	lightpink:[255,182,193],
	lightyellow:[255,255,224],
	lime:[0,255,0],
	magenta:[255,0,255],
	maroon:[128,0,0],
	navy:[0,0,128],
	olive:[128,128,0],
	orange:[255,165,0],
	pink:[255,192,203],
	purple:[128,0,128],
	red:[255,0,0],
	silver:[192,192,192],
	white:[255,255,255],
	yellow:[255,255,0]
};

/**
 * parses a color to an object for reg, green and blue
 */
jQuery.fx.parseColor = function(color, notColor)
{
	if (jQuery.fx.namedColors[color]) 
		return {
			r: jQuery.fx.namedColors[color][0],
			g: jQuery.fx.namedColors[color][1],
			b: jQuery.fx.namedColors[color][2]
		};
	else if (result = /^rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)$/.exec(color))
		return {
			r: parseInt(result[1]),
			g: parseInt(result[2]),
			b: parseInt(result[3])
		};
	else if (result = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)$/.exec(color)) 
		return {
			r: parseFloat(result[1])*2.55,
			g: parseFloat(result[2])*2.55,
			b: parseFloat(result[3])*2.55
		};
	else if (result = /^#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])$/.exec(color))
		return {
			r: parseInt("0x"+ result[1] + result[1]),
			g: parseInt("0x" + result[2] + result[2]),
			b: parseInt("0x" + result[3] + result[3])
		};
	else if (result = /^#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})$/.exec(color))
		return {
			r: parseInt("0x" + result[1]),
			g: parseInt("0x" + result[2]),
			b: parseInt("0x" + result[3])
		};
	else
		return notColor == true ? false : {r: 255, g: 255, b: 255};
};
/**
 * CSS rules that can be animated
 */
jQuery.fx.cssProps = {
	borderBottomWidth:1,
	borderLeftWidth:1,
	borderRightWidth:1,
	borderTopWidth:1,
	bottom:1,
	fontSize:1,
	height:1,
	left:1,
	letterSpacing:1,
	lineHeight:1,
	marginBottom:1,
	marginLeft:1,
	marginRight:1,
	marginTop:1,
	maxHeight:1,
	maxWidth:1,
	minHeight:1,
	minWidth:1,
	opacity:1,
	outlineOffset:1,
	outlineWidth:1,
	paddingBottom:1,
	paddingLeft:1,
	paddingRight:1,
	paddingTop:1,
	right:1,
	textIndent:1,
	top:1,
    width:1,
	zIndex:1
};
/**
 * CSS color rules that can be animated
 */
jQuery.fx.colorCssProps = {
	backgroundColor:1,
	borderBottomColor:1,
	borderLeftColor:1,
	borderRightColor:1,
	borderTopColor:1,
	color:1,
	outlineColor:1
};

jQuery.fx.cssSides = ['Top', 'Right', 'Bottom', 'Left'];
jQuery.fx.cssSidesEnd = {
	'borderWidth': ['border', 'Width'],
	'borderColor': ['border', 'Color'],
	'margin': ['margin', ''],
	'padding': ['padding', '']
};

/**
 * Overwrite animation to use new FX function
 */
jQuery.fn.extend({
	
	animate: function( prop, speed, easing, callback ) {
		return this.queue(function(){
			var opt = jQuery.speed(speed, easing, callback);
			var e = new jQuery.fxe( this, opt, prop );
			
		});
	},
	pause: function(speed, callback) {
		return this.queue(function(){
			var opt = jQuery.speed(speed, callback);
			var e = new jQuery.pause( this, opt );
		});
	},
	stop : function(step) {
		return this.each(function(){
			if (this.animationHandler)
				jQuery.stopAnim(this, step);
			
		});
	},
	stopAll : function(step) {
		return this.each(function(){
			if (this.animationHandler)
				jQuery.stopAnim(this, step);
			if ( this.queue && this.queue['fx'] )
				this.queue.fx = [];
		});
	}
});
/**
 * Improved FXC function that aniamtes collection of properties per timer. Accepts inline styles and class names to animate
 */
jQuery.extend({
	pause: function(elem, options)
	{
		var z = this, values;
		z.step = function()
		{
			if ( jQuery.isFunction( options.complete ) )
				options.complete.apply( elem );
		};
		z.timer=setInterval(function(){z.step();},options.duration);
		elem.animationHandler = z;
	},
	easing :  {
		linear: function(p, n, firstNum, delta, duration) {
			return ((-Math.cos(p*Math.PI)/2) + 0.5) * delta + firstNum;
		}
	},
	fxe: function( elem, options, prop ){
		var z = this, values;

		// The styles
		var y = elem.style;
		var oldOverflow = jQuery.css(elem, "overflow");
		var oldDisplay= jQuery.css(elem, "display");
		var props = {};
		z.startTime = (new Date()).getTime();
		options.easing = options.easing && jQuery.easing[options.easing] ? options.easing : 'linear';
		
		z.getValues = function(tp, vp)
		{
			if (jQuery.fx.cssProps[tp]) {
				if (vp == 'show' || vp == 'hide' || vp == 'toggle') {
					if ( !elem.orig ) elem.orig = {};
					var r = parseFloat( jQuery.curCSS(elem, tp) );
					elem.orig[tp] = r && r > -10000 ? r : (parseFloat( jQuery.css(elem,tp) )||0);
					vp = vp == 'toggle' ? ( oldDisplay == 'none' ? 'show' : 'hide') : vp;
					options[vp] = true;
					props[tp] = vp == 'show' ? [0, elem.orig[tp]] : [elem.orig[tp], 0];
					if (tp != 'opacity')
						y[tp] = props[tp][0] + (tp != 'zIndex' && tp != 'fontWeight' ? 'px':'');
					else
						jQuery.attr(y, "opacity", props[tp][0]);
				} else {
					props[tp] = [parseFloat( jQuery.curCSS(elem, tp) ), parseFloat(vp)||0];
				}
			} else if (jQuery.fx.colorCssProps[tp])
				props[tp] = [jQuery.fx.parseColor(jQuery.curCSS(elem, tp)), jQuery.fx.parseColor(vp)];
			else if(/^margin$|padding$|border$|borderColor$|borderWidth$/i.test(tp)) {
				var m = vp.replace(/\s+/g, ' ').replace(/rgb\s*\(\s*/g,'rgb(').replace(/\s*,\s*/g,',').replace(/\s*\)/g,')').match(/([^\s]+)/g);
				switch(tp){
					case 'margin':
					case 'padding':
					case 'borderWidth':
					case 'borderColor':
						m[3] = m[3]||m[1]||m[0];
						m[2] = m[2]||m[0];
						m[1] = m[1]||m[0];
						for(var i = 0; i < jQuery.fx.cssSides.length; i++) {
							var nmp = jQuery.fx.cssSidesEnd[tp][0] + jQuery.fx.cssSides[i] + jQuery.fx.cssSidesEnd[tp][1];
							props[nmp] = tp == 'borderColor' ?
								[jQuery.fx.parseColor(jQuery.curCSS(elem, nmp)), jQuery.fx.parseColor(m[i])]
								: [parseFloat( jQuery.curCSS(elem, nmp) ), parseFloat(m[i])];
						}
						break;
					case 'border':
						for(var i = 0; i< m.length; i++) {
							var floatVal = parseFloat(m[i]);
							var sideEnd = !isNaN(floatVal) ? 'Width' : (!/transparent|none|hidden|dotted|dashed|solid|double|groove|ridge|inset|outset/i.test(m[i]) ? 'Color' : false);
							if (sideEnd) {
								for(var j = 0; j < jQuery.fx.cssSides.length; j++) {
									nmp = 'border' + jQuery.fx.cssSides[j] + sideEnd;
									props[nmp] = sideEnd == 'Color' ?
								[jQuery.fx.parseColor(jQuery.curCSS(elem, nmp)), jQuery.fx.parseColor(m[i])]
								: [parseFloat( jQuery.curCSS(elem, nmp) ), floatVal];
								}
							} else {
								y['borderStyle'] = m[i];
							}
						}
						break;
				}
			} else {
				y[tp] = vp;
			}
			return false;
		};
		
		for(p in prop) {
			if (p == 'style') {
				var newStyles = jQuery.parseStyle(prop[p]);
				for (np in newStyles) {
					this.getValues(np, newStyles[np]);
				}
			} else if (p == 'className') {
				if (document.styleSheets)
					for (var i=0; i<document.styleSheets.length; i++){
						var cssRules = document.styleSheets[i].cssRules||document.styleSheets[i].rules||null;
						if (cssRules) {
							for (var j=0; j<cssRules.length; j++) {
								if(cssRules[j].selectorText == '.' + prop[p]) {
									var rule = new RegExp('\.' + prop[p] + ' {');
									var styles = cssRules[j].style.cssText;
									var newStyles = jQuery.parseStyle(styles.replace(rule, '').replace(/}/g, ''));
									for (np in newStyles) {
										this.getValues(np, newStyles[np]);
									}
								}
							}
						}
					}
			} else {
				this.getValues(p, prop[p]);
			}
		}
		y.display = oldDisplay == 'none' ? 'block' : oldDisplay;
		y.overflow = 'hidden';
		
		/*if (options.show)
			y.display = "";*/
		
		z.step = function(){
			var t = (new Date()).getTime();
			if (t > options.duration + z.startTime) {
				clearInterval(z.timer);
				z.timer = null;
				for (p in props) {
					if ( p == "opacity" )
						jQuery.attr(y, "opacity", props[p][1]);
					else if (typeof props[p][1] == 'object')
						y[p] = 'rgb(' + props[p][1].r +',' + props[p][1].g +',' + props[p][1].b +')';
					else 
						y[p] = props[p][1] + (p != 'zIndex' && p != 'fontWeight' ? 'px':'');
				}
				if ( options.hide || options.show )
					for ( var p in elem.orig )
						if (p == "opacity")
							jQuery.attr(y, p, elem.orig[p]);
						else
							y[p] = "";
				y.display = options.hide ? 'none' : (oldDisplay !='none' ? oldDisplay : 'block');
				y.overflow = oldOverflow;
				elem.animationHandler = null;
				if ( jQuery.isFunction( options.complete ) )
					options.complete.apply( elem );
			} else {
				var n = t - this.startTime;
				var pr = n / options.duration;
				for (p in props) {
					if (typeof props[p][1] == 'object') {
						y[p] = 'rgb('
						+ parseInt(jQuery.easing[options.easing](pr, n,  props[p][0].r, (props[p][1].r-props[p][0].r), options.duration))
						+ ','
						+ parseInt(jQuery.easing[options.easing](pr, n,  props[p][0].g, (props[p][1].g-props[p][0].g), options.duration))
						+ ','
						+ parseInt(jQuery.easing[options.easing](pr, n,  props[p][0].b, (props[p][1].b-props[p][0].b), options.duration))
						+')';
					} else {
						var pValue = jQuery.easing[options.easing](pr, n,  props[p][0], (props[p][1]-props[p][0]), options.duration);
						if ( p == "opacity" )
							jQuery.attr(y, "opacity", pValue);
						else 
							y[p] = pValue + (p != 'zIndex' && p != 'fontWeight' ? 'px':'');
					}
				}

			}
		};
	z.timer=setInterval(function(){z.step();},13);
	elem.animationHandler = z;
	},
	stopAnim: function(elem, step)
	{
		if (step)
			elem.animationHandler.startTime -= 100000000;
		else {
			window.clearInterval(elem.animationHandler.timer);
			elem.animationHandler = null;
			jQuery.dequeue(elem, "fx");
		}
	}
}
);

jQuery.parseStyle = function(styles) {
	var newStyles = {};
	if (typeof styles == 'string') {
		styles = styles.toLowerCase().split(';');
		for(var i=0; i< styles.length; i++){
			rule = styles[i].split(':');
			if (rule.length == 2) {
				newStyles[jQuery.trim(rule[0].replace(/\-(\w)/g,function(m,c){return c.toUpperCase();}))] = jQuery.trim(rule[1]);
			}
		}
	}
	return newStyles;
};/**
 * Interface Elements for jQuery
 * FX - blind
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */
 
/**
 * Applies a blinding animation to element
 */
jQuery.fn.extend(
	{
		/**
		 * @name BlindUp
		 * @description blinds the element up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		BlindUp : function (speed, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.BlindDirection(this, speed, callback, 'up', easing);
			});
		},
		
		/**
		 * @name BlindDown
		 * @description blinds the element down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		BlindDown : function (speed, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.BlindDirection(this, speed, callback, 'down', easing);
			});
		},
		
		/**
		 * @name BlindToggleVertically
		 * @description blinds the element up or down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		BlindToggleVertically : function (speed, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.BlindDirection(this, speed, callback, 'togglever', easing);
			});
		},
		
		/**
		 * @name BlindLeft
		 * @description blinds the element left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		BlindLeft : function (speed, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.BlindDirection(this, speed, callback, 'left', easing);
			});
		},
		
		/**
		 * @name BlindRight
		 * @description blinds the element right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		BlindRight : function (speed, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.BlindDirection(this, speed, callback, 'right', easing);
			});
		},
		
		/**
		 * @name BlindToggleHorizontally
		 * @description blinds the element left and right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		BlindToggleHorizontally : function (speed, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.BlindDirection(this, speed, callback, 'togglehor', easing);
			});
		}
	}
);

jQuery.fx.BlindDirection = function (e, speed, callback, direction, easing)
{
	if (!jQuery.fxCheckTag(e)) {
		jQuery.dequeue(e, 'interfaceFX');
		return false;
	}
	var z = this;
	z.el = jQuery(e);
	z.size = jQuery.iUtil.getSize(e);
	z.easing = typeof callback == 'string' ? callback : easing||null;
	if (!e.ifxFirstDisplay)
		e.ifxFirstDisplay = z.el.css('display');
	if ( direction == 'togglever') {
		direction = z.el.css('display') == 'none' ? 'down' : 'up';
	} else if (direction == 'togglehor') {
		direction = z.el.css('display') == 'none' ? 'right' : 'left';
	}
	z.el.show();
	z.speed = speed;
	z.callback = typeof callback == 'function' ? callback : null;
	z.fx = jQuery.fx.buildWrapper(e);
	z.direction = direction;
	z.complete = function()
	{
		if (z.callback && z.callback.constructor == Function) {
			z.callback.apply(z.el.get(0));
		}
		if(z.direction == 'down' || z.direction == 'right'){
			z.el.css('display', z.el.get(0).ifxFirstDisplay == 'none' ? 'block' : z.el.get(0).ifxFirstDisplay);
		} else {
			z.el.hide();
		}
		jQuery.fx.destroyWrapper(z.fx.wrapper.get(0), z.fx.oldStyle);
		jQuery.dequeue(z.el.get(0), 'interfaceFX');
	};
	switch (z.direction) {
		case 'up':
			fxh = new jQuery.fx(
				z.fx.wrapper.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'height'
			);
			fxh.custom(z.fx.oldStyle.sizes.hb, 0);
		break;
		case 'down':
			z.fx.wrapper.css('height', '1px');
			z.el.show();
			fxh = new jQuery.fx(
				z.fx.wrapper.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'height'
			);
			fxh.custom(0, z.fx.oldStyle.sizes.hb);
		break;
		case 'left':
			fxh = new jQuery.fx(
				z.fx.wrapper.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'width'
			);
			fxh.custom(z.fx.oldStyle.sizes.wb, 0);
		break;
		case 'right':
			z.fx.wrapper.css('width', '1px');
			z.el.show();
			fxh = new jQuery.fx(
				z.fx.wrapper.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'width'
			);
			fxh.custom(0, z.fx.oldStyle.sizes.wb);
		break;
	}
};/**
 * Interface Elements for jQuery
 * FX - bounce
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * @name Bounce
 * @description makes the element to bounce
 * @param Integer hight the hight in pxels for element to jumps to
 * @param Function callback (optional) A function to be executed whenever the animation completes.
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.fn.Bounce = function (hight, callback) {
	return this.queue('interfaceFX', function(){
		if (!jQuery.fxCheckTag(this)) {
			jQuery.dequeue(this, 'interfaceFX');
			return false;
		}
		var e = new jQuery.fx.iBounce(this, hight, callback);
		e.bounce();
	});
};
jQuery.fx.iBounce = function (e, hight, callback)
{
	var z = this;
	z.el = jQuery(e);
	z.el.show();
	z.callback = callback;
	z.hight = parseInt(hight)||40;
	z.oldStyle = {};
	z.oldStyle.position = z.el.css('position');
	z.oldStyle.top = parseInt(z.el.css('top'))||0;
	z.oldStyle.left = parseInt(z.el.css('left'))||0;
	
	if (z.oldStyle.position != 'relative' && z.oldStyle.position != 'absolute') {
		z.el.css('position', 'relative');
	}
	
	z.times = 5;
	z.cnt = 1;
	
	z.bounce = function ()
	{
		z.cnt ++;
		z.e = new jQuery.fx(
			z.el.get(0), 
			{
			 duration: 120,
			 complete : function ()
			 {
				z.e = new jQuery.fx(
					z.el.get(0), 
					{
						duration: 80,
						complete : function ()
						{
							z.hight = parseInt(z.hight/2);
							if (z.cnt <= z.times)
								z.bounce();
							else {
								z.el.css('position', z.oldStyle.position).css('top', z.oldStyle.top + 'px').css('left', z.oldStyle.left + 'px');
								jQuery.dequeue(z.el.get(0), 'interfaceFX');
								if (z.callback && z.callback.constructor == Function) {
									z.callback.apply(z.el.get(0));
								}
							}
						}
					},
					'top'
				);
				z.e.custom (z.oldStyle.top-z.hight, z.oldStyle.top);
			 }
			}, 
			'top'
		);
		z.e.custom (z.oldStyle.top, z.oldStyle.top-z.hight);
	};
		
};/**
 * Interface Elements for jQuery
 * FX - drop
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Applies a dropping effect to element
 */
jQuery.fn.extend(
	{
		/**
		 * @name DropOutDown
		 * @description drops the element out down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropOutDown : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this, speed, callback, 'down', 'out', easing);
			});
		},
		
		/**
		 * @name DropInDown
		 * @description drops the element in down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropInDown : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'down', 'in', easing);
			});
		},
		
		/**
		 * @name DropToggleDown
		 * @description drops the element in/out down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropToggleDown : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'down', 'toggle', easing);
			});
		},
		
		/**
		 * @name DropOutUp
		 * @description drops the element out up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropOutUp : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this, speed, callback, 'up', 'out', easing);
			});
		},
		
		/**
		 * @name DropInUp
		 * @description drops the element in up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropInUp : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'up', 'in', easing);
			});
		},
		
		/**
		 * @name DropToggleUp
		 * @description drops the element in/out up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropToggleUp : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'up', 'toggle', easing);
			});
		},
		
		/**
		 * @name DropOutLeft
		 * @description drops the element out left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropOutLeft : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this, speed, callback, 'left', 'out', easing);
			});
		},
		
		/**
		 * @name DropInLeft
		 * @description drops the element in left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropInLeft : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'left', 'in', easing);
			});
		},
		
		/**
		 * @name DropToggleLeft
		 * @description drops the element in/out left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropToggleLeft : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'left', 'toggle', easing);
			});
		},
		
		/**
		 * @name DropOutRight
		 * @description drops the element out right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropOutRight : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this, speed, callback, 'right', 'out', easing);
			});
		},
		
		/**
		 * @name DropInRight
		 * @description drops the element in right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropInRight : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'right', 'in', easing);
			});
		},
		
		/**
		 * @name DropToggleRight
		 * @description drops the element in/out right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DropToggleRight : function (speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DropOutDirectiont(this,  speed, callback, 'right', 'toggle', easing);
			});
		}
	}
);

jQuery.fx.DropOutDirectiont = function (e, speed, callback, direction, type, easing)
{
	if (!jQuery.fxCheckTag(e)) {
		jQuery.dequeue(e, 'interfaceFX');
		return false;
	}
	var z = this;
	z.el = jQuery(e);
	z.easing = typeof callback == 'string' ? callback : easing||null;
	z.oldStyle = {};
	z.oldStyle.position = z.el.css('position');
	z.oldStyle.top = z.el.css('top');
	z.oldStyle.left = z.el.css('left');
	if (!e.ifxFirstDisplay)
		e.ifxFirstDisplay = z.el.css('display');
	if ( type == 'toggle') {
		type = z.el.css('display') == 'none' ? 'in' : 'out';
	}
	z.el.show();
	
	if (z.oldStyle.position != 'relative' && z.oldStyle.position != 'absolute') {
		z.el.css('position', 'relative');
	}
	z.type = type;
	callback = typeof callback == 'function' ? callback : null;
	/*sizes = ['em','px','pt','%'];
	for(i in sizes) {
		if (z.oldStyle.top.indexOf(sizes[i])>0) {
			z.topUnit = sizes[1];
			z.topSize = parseFloat(z.oldStyle.top)||0;
		}
		if (z.oldStyle.left.indexOf(sizes[i])>0) {
			z.leftUnit = sizes[1];
			z.leftSize = parseFloat(z.oldStyle.left)||0;
		}
	}*/
	
	directionIncrement = 1;
	switch (direction){
		case 'up':
			z.e = new jQuery.fx(z.el.get(0), jQuery.speed(speed - 15, z.easing,callback), 'top');
			z.point = parseFloat(z.oldStyle.top)||0;
			z.unit = z.topUnit;
			directionIncrement = -1;
		break;
		case 'down':
			z.e = new jQuery.fx(z.el.get(0), jQuery.speed(speed - 15, z.easing,callback), 'top');
			z.point = parseFloat(z.oldStyle.top)||0;
			z.unit = z.topUnit;
		break;
		case 'right':
			z.e = new jQuery.fx(z.el.get(0), jQuery.speed(speed - 15, z.easing,callback), 'left');
			z.point = parseFloat(z.oldStyle.left)||0;
			z.unit = z.leftUnit;
		break;
		case 'left':
			z.e = new jQuery.fx(z.el.get(0), jQuery.speed(speed - 15, z.easing,callback), 'left');
			z.point = parseFloat(z.oldStyle.left)||0;
			z.unit = z.leftUnit;
			directionIncrement = -1;
		break;
	}
	z.e2 = new jQuery.fx(
		z.el.get(0),
		jQuery.speed
		(
		 	speed, z.easing,
			function()
			{
				z.el.css(z.oldStyle);
				if (z.type == 'out') {
					z.el.css('display', 'none');
				} else 
					z.el.css('display', z.el.get(0).ifxFirstDisplay == 'none' ? 'block' : z.el.get(0).ifxFirstDisplay);
				
				jQuery.dequeue(z.el.get(0), 'interfaceFX');
			}
		 ),
		'opacity'
	);
	if (type == 'in') {
		z.e.custom(z.point+ 100*directionIncrement, z.point);
		z.e2.custom(0,1);
	} else {
		z.e.custom(z.point, z.point + 100*directionIncrement);
		z.e2.custom(1,0);
	}
};/**
 * Interface Elements for jQuery
 * FX - fold
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Applies a folding animation to element
 */
jQuery.fn.extend(
	{
		/**
		 * @name Fold
		 * @description folds the element
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Integer height the height in pixels to fold element to
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Fold : function (speed, height, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DoFold(this, speed, height, callback, 'fold', easing);
			});
		},
		
		/**
		 * @name UnFold
		 * @description unfolds the element
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Integer height the height in pixels to unfold element to
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		UnFold : function (speed, height, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DoFold(this, speed, height, callback, 'unfold', easing);
			});
		},
		
		/**
		 * @name FoldToggle
		 * @description folds/unfolds the element
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Integer height the height in pixels to folds/unfolds element to
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		FoldToggle : function (speed, height, callback, easing)
		{
			return this.queue('interfaceFX',function(){
				new jQuery.fx.DoFold(this, speed, height, callback, 'toggle', easing);
			});
		}
	}
);

jQuery.fx.DoFold = function (e, speed, height, callback, type, easing)
{
	if (!jQuery.fxCheckTag(e)) {
		jQuery.dequeue(e, 'interfaceFX');
		return false;
	}
	var z = this;
	z.el = jQuery(e);
	z.easing = typeof callback == 'string' ? callback : easing||null;
	z.callback = typeof callback == 'function' ? callback : null;
	if ( type == 'toggle') {
		type = z.el.css('display') == 'none' ? 'unfold' : 'fold';
	}
	//z.el.show();
	z.speed = speed;
	z.height = height && height.constructor == Number ? height : 20;
	z.fx = jQuery.fx.buildWrapper(e);
	z.type = type;
	z.complete = function()
	{
		if (z.callback && z.callback.constructor == Function) {
			z.callback.apply(z.el.get(0));
		}
		if(z.type == 'unfold'){
			z.el.show();
		} else {
			z.el.hide();
		}
		jQuery.fx.destroyWrapper(z.fx.wrapper.get(0), z.fx.oldStyle);
		jQuery.dequeue(z.el.get(0), 'interfaceFX');
	};
	if ( z.type == 'unfold') {
		z.el.show();
		z.fx.wrapper.css('height', z.height + 'px').css('width', '1px');
		
		z.ef = new jQuery.fx(
				z.fx.wrapper.get(0),
				jQuery.speed (
					z.speed,
					z.easing,
					function()
					{
						z.ef = new jQuery.fx(
							z.fx.wrapper.get(0),
							jQuery.speed(
								z.speed,
								z.easing, 
								z.complete
							),
							'height'
						);
						z.ef.custom(z.height, z.fx.oldStyle.sizes.hb);
					}
				), 
				'width'
			);
		z.ef.custom(0, z.fx.oldStyle.sizes.wb);
	} else {
		z.ef = new jQuery.fx(
				z.fx.wrapper.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					function()
					{
						z.ef = new jQuery.fx(
							z.fx.wrapper.get(0),
							jQuery.speed(
								z.speed,
								z.easing,
								z.complete
							),
							'width'
						);
						z.ef.custom(z.fx.oldStyle.sizes.wb, 0);
					}
				), 
				'height'
			);
		z.ef.custom(z.fx.oldStyle.sizes.hb, z.height);
	}
};

/**
 * Interface Elements for jQuery
 * FX - Highlight
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */


/**
 * @name Highlight
 * @description Animates the backgroudn color to create a highlight animation
 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
 * @param String color color to highlight from
 * @param Function callback (optional) A function to be executed whenever the animation completes.
 * @param String easing (optional) The name of the easing effect that you want to use.
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.fn.Highlight = function(speed, color, callback, easing) {
	return this.queue(
		'interfaceColorFX',
		function()
		{
			this.oldStyleAttr = jQuery(this).attr("style") || '';
			easing = typeof callback == 'string' ? callback : easing||null;
			callback = typeof callback == 'function' ? callback : null;
			var oldColor = jQuery(this).css('backgroundColor');
			var parentEl = this.parentNode;
			while(oldColor == 'transparent' && parentEl) {
				oldColor = jQuery(parentEl).css('backgroundColor');
				parentEl = parentEl.parentNode;
			}
			jQuery(this).css('backgroundColor', color);
			
			
			/* In IE, style is a object.. */
			if(typeof this.oldStyleAttr == 'object') this.oldStyleAttr = this.oldStyleAttr["cssText"];
			
			jQuery(this).animate(
				{'backgroundColor':oldColor},
				speed,
				easing,
				function() {
					jQuery.dequeue(this, 'interfaceColorFX');
					if(typeof jQuery(this).attr("style") == 'object') {
						jQuery(this).attr("style")["cssText"] = "";
						jQuery(this).attr("style")["cssText"] = this.oldStyleAttr;
					} else {
						jQuery(this).attr("style", this.oldStyleAttr);	
					}
					if (callback)
						callback.apply(this);
				}
		  	);
		}
	);
};/**
 * Interface Elements for jQuery
 * FX - open/close/switch
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Applies an open/close animation to element
 */
jQuery.fn.extend(
	{
		/**
		 * @name CloseVertically
		 * @description closes the element vertically
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		CloseVertically : function (speed, callback, easing) {
			return this.queue('interfaceFX', function(){
				new jQuery.fx.OpenClose(this, speed, callback, 'vertically', 'close', easing);
			});
		},
		
		/**
		 * @name CloseHorizontally
		 * @description closes the element horizontally
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		CloseHorizontally : function (speed, callback, easing) {
			return this.queue('interfaceFX', function(){
				new jQuery.fx.OpenClose(this, speed, callback, 'horizontally', 'close', easing);
			});
		},
		
		/**
		 * @name SwitchHorizontally
		 * @description opens/closes the element horizontally
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SwitchHorizontally : function (speed, callback, easing) 
		{
			return this.queue('interfaceFX', function(){
				if (jQuery.css(this, 'display') == 'none') {
					new jQuery.fx.OpenClose(this, speed, callback, 'horizontally', 'open', easing);
				} else {
					new jQuery.fx.OpenClose(this, speed, callback, 'horizontally', 'close', easing);
				}
			});
		},
		
		/**
		 * @name SwitchVertically
		 * @description opens/closes the element vertically
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SwitchVertically : function (speed, callback, easing) 
		{
			return this.queue('interfaceFX', function(){
				if (jQuery.css(this, 'display') == 'none') {
					new jQuery.fx.OpenClose(this, speed, callback, 'vertically', 'open', easing);
				} else {
					new jQuery.fx.OpenClose(this, speed, callback, 'vertically', 'close', easing);
				}
			});
		},
		
		/**
		 * @name OpenVertically
		 * @description opens the element vertically
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		OpenVertically : function (speed, callback, easing) {
			return this.queue('interfaceFX', function(){
				new jQuery.fx.OpenClose(this, speed, callback, 'vertically', 'open', easing);
			});
		},
		
		/**
		 * @name OpenHorizontally
		 * @description opens the element horizontally
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		OpenHorizontally : function (speed, callback, easing) {
			return this.queue('interfaceFX', function(){
				new jQuery.fx.OpenClose(this, speed, callback, 'horizontally', 'open', easing);
			});
		}
	}
);

jQuery.fx.OpenClose = function (e, speed, callback, direction, type, easing)
{
	if (!jQuery.fxCheckTag(e)) {
		jQuery.dequeue(e, 'interfaceFX');
		return false;
	}
	var z = this;
	var restoreStyle = false;
	z.el = jQuery(e);
	z.easing = typeof callback == 'string' ? callback : easing||null;
	z.callback = typeof callback == 'function' ? callback : null;
	z.type = type;
	z.speed = speed;
	z.oldP = jQuery.iUtil.getSize(e);
	z.oldStyle = {};
	z.oldStyle.position = z.el.css('position');
	z.oldStyle.display = z.el.css('display');
	if (z.oldStyle.display == 'none') {
		oldVisibility = z.el.css('visibility');
		z.el.show();
		restoreStyle = true;
	}
	z.oldStyle.top = z.el.css('top');
	z.oldStyle.left = z.el.css('left');
	if (restoreStyle) {
		z.el.hide();
		z.el.css('visibility', oldVisibility);
	}
	z.oldStyle.width = z.oldP.w + 'px';
	z.oldStyle.height = z.oldP.h + 'px';
	z.oldStyle.overflow = z.el.css('overflow');
	z.oldP.top = parseInt(z.oldStyle.top)||0;
	z.oldP.left = parseInt(z.oldStyle.left)||0;
	//z.el.show();
	
	if (z.oldStyle.position != 'relative' && z.oldStyle.position != 'absolute') {
		z.el.css('position', 'relative');
	}
	z.el.css('overflow', 'hidden')
		.css('height', type == 'open' && direction == 'vertically' ? 1 : z.oldP.h + 'px')
		.css('width', type == 'open' && direction == 'horizontally' ? 1 : z.oldP.w + 'px');
	
	z.complete = function()
	{
		z.el.css(z.oldStyle);
		if (z.type == 'close')
			z.el.hide();
		else 
			z.el.show();
		jQuery.dequeue(z.el.get(0), 'interfaceFX');
	};
	
	switch (direction) {
		case 'vertically':
			z.eh = new jQuery.fx(
				z.el.get(0),
				jQuery.speed(speed-15, z.easing, callback),
				'height'
			);
			z.et = new jQuery.fx(
				z.el.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'top'
			);
			if (z.type == 'close') {
				z.eh.custom(z.oldP.h,0);
				z.et.custom(z.oldP.top, z.oldP.top + z.oldP.h/2);
			} else {
				z.eh.custom(0, z.oldP.h);
				z.et.custom(z.oldP.top + z.oldP.h/2, z.oldP.top);
			}
		break;
		case 'horizontally':
			z.eh = new jQuery.fx(
				z.el.get(0),
				jQuery.speed(speed-15, z.easing, callback),
				'width'
			);
			z.et = new jQuery.fx(
				z.el.get(0),
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'left'
			);
			if (z.type == 'close') {
				z.eh.custom(z.oldP.w,0);
				z.et.custom(z.oldP.left, z.oldP.left + z.oldP.w/2);
			} else {
				z.eh.custom(0, z.oldP.w);
				z.et.custom(z.oldP.left + z.oldP.w/2, z.oldP.left);
			}
		break;
	}
};/**
 * Interface Elements for jQuery
 * FX - pulsate
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */
 
/**
 * @name Bounce
 * @description makes the element to pulsate
 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
 * @param Integer times how many times to pulsate
 * @param Function callback (optional) A function to be executed whenever the animation completes.
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.fn.Pulsate = function(speed, times, callback) {
	return this.queue('interfaceFX',function(){
		if (!jQuery.fxCheckTag(this)) {
			jQuery.dequeue(this, 'interfaceFX');
			return false;
		}
		var fx = new jQuery.fx.Pulsate(this, speed, times, callback);
		fx.pulse();
	});
};

jQuery.fx.Pulsate = function (el, speed, times, callback)
{	
	var z = this;
	z.times = times;
	z.cnt = 1;
	z.el = el;
	z.speed = speed;
	z.callback = callback;
	jQuery(z.el).show();
	z.pulse = function()
	{
		z.cnt ++;
		z.e = new jQuery.fx(
			z.el, 
			jQuery.speed(
				z.speed, 
				function(){
					z.ef = new jQuery.fx(
						z.el, 
						jQuery.speed(
							z.speed,
							function()
							{
								if (z.cnt <= z.times)
									z.pulse();
								else {
									jQuery.dequeue(z.el, 'interfaceFX');
									if (z.callback && z.callback.constructor == Function) {
										z.callback.apply(z.el);
									}
								}
							}
						), 
						'opacity'
					);
					z.ef.custom(0,1);
				}
			), 
			'opacity'
		);
		z.e.custom(1,0);
	};
};
/**
 * Interface Elements for jQuery
 * FX - scale/grow/shrink/puff
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */
/**
 * Applies a scallign animation to element
 */
jQuery.fn.extend(
	{
		/**
		 * @name Grow
		 * @description scales the element from 0 to intitial size
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Grow : function(speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.Scale(this, speed, 1, 100, true, callback, 'grow', easing);
			});
		},
		
		/**
		 * @name Shrink
		 * @description scales the element from intitial size to 0
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Shrink : function(speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.Scale(this, speed, 100, 1, true, callback, 'shrink', easing);
			});
		},
		
		/**
		 * @name Puff
		 * @description makes element to dispear by scalling to 150% and fading it out
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Puff : function(speed, callback, easing) {
			return this.queue('interfaceFX',function(){
				var easing = easing || 'easeout';
				new jQuery.fx.Scale(this, speed, 100, 150, true, callback, 'puff', easing);
			});
		},
		
		/**
		 * @name Scale
		 * @description scales the element
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Integer from initial scalling procentage
		 * @param Integer to final scalling procentage
		 * @param Boolean reastore whatever to restore the initital scalling procentage when animation ends
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Scale : function(speed, from, to, restore, callback, easing) {
			return this.queue('interfaceFX',function(){
				new jQuery.fx.Scale(this, speed, from, to, restore, callback, 'Scale', easing);
			});
		}
	}
);

jQuery.fx.Scale = function (e, speed, from, to, restore, callback, type, easing)
{
	if (!jQuery.fxCheckTag(e)) {
		jQuery.dequeue(e, 'interfaceFX');
		return false;
	}
	var z = this;
	z.el = jQuery(e);
	z.from = parseInt(from) || 100;
	z.to = parseInt(to) || 100;
	z.easing = typeof callback == 'string' ? callback : easing||null;
	z.callback = typeof callback == 'function' ? callback : null;
	z.duration = jQuery.speed(speed).duration;
	z.restore = restore|| null;
	z.oldP = jQuery.iUtil.getSize(e);
	z.oldStyle = {
		width: z.el.css('width'),
		height: z.el.css('height'),
		fontSize: z.el.css('fontSize')||'100%',
		position : z.el.css('position'),
		display : z.el.css('display'),
		top : z.el.css('top'),
		left : z.el.css('left'),
		overflow : z.el.css('overflow'),
		borderTopWidth : z.el.css('borderTopWidth'),
		borderRightWidth : z.el.css('borderRightWidth'),
		borderBottomWidth : z.el.css('borderBottomWidth'),
		borderLeftWidth : z.el.css('borderLeftWidth'),
		paddingTop : z.el.css('paddingTop'),
		paddingRight : z.el.css('paddingRight'),
		paddingBottom : z.el.css('paddingBottom'),
		paddingLeft : z.el.css('paddingLeft')
	};
	z.width = parseInt(z.oldStyle.width)||e.offsetWidth||0;
	z.height = parseInt(z.oldStyle.height)||e.offsetHeight||0;
	z.top = parseInt(z.oldStyle.top)||0;
	z.left = parseInt(z.oldStyle.left)||0;
	sizes = ['em','px','pt','%'];
	for(i in sizes) {
		if (z.oldStyle.fontSize.indexOf(sizes[i])>0) {
			z.fontUnit = sizes[i];
			z.fontSize = parseFloat(z.oldStyle.fontSize);
		}
		if (z.oldStyle.borderTopWidth.indexOf(sizes[i])>0) {
			z.borderTopUnit = sizes[i];
			z.borderTopSize = parseFloat(z.oldStyle.borderTopWidth)||0;
		}
		if (z.oldStyle.borderRightWidth.indexOf(sizes[i])>0) {
			z.borderRightUnit = sizes[i];
			z.borderRightSize = parseFloat(z.oldStyle.borderRightWidth)||0;
		}
		if (z.oldStyle.borderBottomWidth.indexOf(sizes[i])>0) {
			z.borderBottomUnit = sizes[i];
			z.borderBottomSize = parseFloat(z.oldStyle.borderBottomWidth)||0;
		}
		if (z.oldStyle.borderLeftWidth.indexOf(sizes[i])>0) {
			z.borderLeftUnit = sizes[i];
			z.borderLeftSize = parseFloat(z.oldStyle.borderLeftWidth)||0;
		}
		if (z.oldStyle.paddingTop.indexOf(sizes[i])>0) {
			z.paddingTopUnit = sizes[i];
			z.paddingTopSize = parseFloat(z.oldStyle.paddingTop)||0;
		}
		if (z.oldStyle.paddingRight.indexOf(sizes[i])>0) {
			z.paddingRightUnit = sizes[i];
			z.paddingRightSize = parseFloat(z.oldStyle.paddingRight)||0;
		}
		if (z.oldStyle.paddingBottom.indexOf(sizes[i])>0) {
			z.paddingBottomUnit = sizes[i];
			z.paddingBottomSize = parseFloat(z.oldStyle.paddingBottom)||0;
		}
		if (z.oldStyle.paddingLeft.indexOf(sizes[i])>0) {
			z.paddingLeftUnit = sizes[i];
			z.paddingLeftSize = parseFloat(z.oldStyle.paddingLeft)||0;
		}
	}
	
	
	if (z.oldStyle.position != 'relative' && z.oldStyle.position != 'absolute') {
		z.el.css('position', 'relative');
	}
	z.el.css('overflow', 'hidden');
	z.type = type;
	switch(z.type)
	{
		case 'grow':
			z.startTop = z.top + z.oldP.h/2;
			z.endTop = z.top;
			z.startLeft = z.left + z.oldP.w/2;
			z.endLeft = z.left;
			break;
		case 'shrink':
			z.endTop = z.top + z.oldP.h/2;
			z.startTop = z.top;
			z.endLeft = z.left + z.oldP.w/2;
			z.startLeft = z.left;
			break;
		case 'puff':
			z.endTop = z.top - z.oldP.h/4;
			z.startTop = z.top;
			z.endLeft = z.left - z.oldP.w/4;
			z.startLeft = z.left;
			break;
	}
	z.firstStep = false;
	z.t=(new Date).getTime();
	z.clear = function(){clearInterval(z.timer);z.timer=null;};
	z.step = function(){
		if (z.firstStep == false) {
			z.el.show();
			z.firstStep = true;
		}
		var t = (new Date).getTime();
		var n = t - z.t;
		var p = n / z.duration;
		if (t >= z.duration+z.t) {
			setTimeout(
				function(){
						o = 1;	
					if (z.type) {
						t = z.endTop;
						l = z.endLeft;
						if (z.type == 'puff')
							o = 0;
					}
					z.zoom(z.to, l, t, true, o);
				},
				13
			);
			z.clear();
		} else {
			o = 1;
			if (!jQuery.easing || !jQuery.easing[z.easing]) {
				s = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.to-z.from) + z.from;
			} else {
				s = jQuery.easing[z.easing](p, n, z.from, (z.to-z.from), z.duration);
			}
			if (z.type) {
				if (!jQuery.easing || !jQuery.easing[z.easing]) {
					t = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.endTop-z.startTop) + z.startTop;
					l = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.endLeft-z.startLeft) + z.startLeft;
					if (z.type == 'puff')
						o = ((-Math.cos(p*Math.PI)/2) + 0.5) * (-0.9999) + 0.9999;
				} else {
					t = jQuery.easing[z.easing](p, n, z.startTop, (z.endTop-z.startTop), z.duration);
					l = jQuery.easing[z.easing](p, n, z.startLeft, (z.endLeft-z.startLeft), z.duration);
					if (z.type == 'puff')
						o = jQuery.easing[z.easing](p, n, 0.9999, -0.9999, z.duration);
				}
			}
			z.zoom(s, l, t, false, o);
		}
	};
	z.timer=setInterval(function(){z.step();},13);
	z.zoom = function(percent, left, top, finish, opacity)
	{
		z.el
			.css('height', z.height * percent/100 + 'px')
			.css('width', z.width * percent/100 + 'px')
			.css('left', left + 'px')
			.css('top', top + 'px')
			.css('fontSize', z.fontSize * percent /100 + z.fontUnit);
		if (z.borderTopSize)
			z.el.css('borderTopWidth', z.borderTopSize * percent /100 + z.borderTopUnit);
		if (z.borderRightSize)
			z.el.css('borderRightWidth', z.borderRightSize * percent /100 + z.borderRightUnit);
		if (z.borderBottomSize)
			z.el.css('borderBottomWidth', z.borderBottomSize * percent /100 + z.borderBottomUnit);
		if (z.borderLeftSize)
			z.el.css('borderLeftWidth', z.borderLeftSize * percent /100 + z.borderLeftUnit);
		if (z.paddingTopSize)
			z.el.css('paddingTop', z.paddingTopSize * percent /100 + z.paddingTopUnit);
		if (z.paddingRightSize)
			z.el.css('paddingRight', z.paddingRightSize * percent /100 + z.paddingRightUnit);
		if (z.paddingBottomSize)
			z.el.css('paddingBottom', z.paddingBottomSize * percent /100 + z.paddingBottomUnit);
		if (z.paddingLeftSize)
			z.el.css('paddingLeft', z.paddingLeftSize * percent /100 + z.paddingLeftUnit);
		if (z.type == 'puff') {
			if (window.ActiveXObject)
				z.el.get(0).style.filter = "alpha(opacity=" + opacity*100 + ")";
			z.el.get(0).style.opacity = opacity;
		}
		if (finish){
			if (z.restore){
				z.el.css(z.oldStyle);
			}
			if (z.type == 'shrink' || z.type == 'puff'){
				z.el.css('display', 'none');
				if (z.type == 'puff') {
					if (window.ActiveXObject)
						z.el.get(0).style.filter = "alpha(opacity=" + 100 + ")";
					z.el.get(0).style.opacity = 1;
				}
			}else 
				z.el.css('display', 'block');
			if (z.callback)
				z.callback.apply(z.el.get(0));
			
			jQuery.dequeue(z.el.get(0), 'interfaceFX');
		}
	};
};/**
 * Interface Elements for jQuery
 * FX - scroll to
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */
/**
 * Applies a scrolling effect to document until the element gets into viewport
 */
jQuery.fn.extend (
	{
		/**
		 * @name ScrollTo
		 * @description scrolls the document until the lement gets into viewport
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param String axis (optional) whatever to scroll on vertical, horizontal or both axis ['vertical'|'horizontal'|null]
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		ScrollTo : function(speed, axis, easing) {
			o = jQuery.speed(speed);
			return this.queue('interfaceFX',function(){
				new jQuery.fx.ScrollTo(this, o, axis, easing);
			});
		},
		/**
		 * @name ScrollToAnchors
		 * @description all links to '#elementId' will animate scroll
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param String axis (optional) whatever to scroll on vertical, horizontal or both axis ['vertical'|'horizontal'|null]
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		/*inspired by David Maciejewski www.macx.de*/
		ScrollToAnchors : function(speed, axis, easing) {
			return this.each(
				function()
				{
					jQuery('a[@href*="#"]', this).click(
						function(e)
						{
							parts = this.href.split('#');
							jQuery('#' + parts[1]).ScrollTo(speed, axis, easing);
							return false;
						}
					);
				}
			)
		}
	}
);

jQuery.fx.ScrollTo = function (e, o, axis, easing)
{
	var z = this;
	z.o = o;
	z.e = e;
	z.axis = /vertical|horizontal/.test(axis) ? axis : false;
	z.easing = easing;
	p = jQuery.iUtil.getPosition(e);
	s = jQuery.iUtil.getScroll();
	z.clear = function(){clearInterval(z.timer);z.timer=null;jQuery.dequeue(z.e, 'interfaceFX');};
	z.t=(new Date).getTime();
	s.h = s.h > s.ih ? (s.h - s.ih) : s.h;
	s.w = s.w > s.iw ? (s.w - s.iw) : s.w;
	z.endTop = p.y > s.h ? s.h : p.y;
	z.endLeft = p.x > s.w ? s.w : p.x;
	z.startTop = s.t;
	z.startLeft = s.l;
	z.step = function(){
		var t = (new Date).getTime();
		var n = t - z.t;
		var p = n / z.o.duration;
		if (t >= z.o.duration+z.t) {
			z.clear();
			setTimeout(function(){z.scroll(z.endTop, z.endLeft)},13);
		} else {
			if (!z.axis || z.axis == 'vertical') {
				if (!jQuery.easing || !jQuery.easing[z.easing]) {
					st = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.endTop-z.startTop) + z.startTop;
				} else {
					st = jQuery.easing[z.easing](p, n, z.startTop, (z.endTop - z.startTop), z.o.duration);
				}
			} else {
				st = z.startTop;
			}
			if (!z.axis || z.axis == 'horizontal') {
				if (!jQuery.easing || !jQuery.easing[z.easing]) {
					sl = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.endLeft-z.startLeft) + z.startLeft;
				} else {
					sl = jQuery.easing[z.easing](p, n, z.startLeft, (z.endLeft - z.startLeft), z.o.duration);
				}
			} else {
				sl = z.startLeft;
			}
			z.scroll(st, sl);
		}
	};
	z.scroll = function (t, l){window.scrollTo(l, t);};
	z.timer=setInterval(function(){z.step();},13);
};/**
 * Interface Elements for jQuery
 * FX - shake
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * @name Shake
 * @description makes the element to shake
 * @param Integer times how many tomes to shake the element
 * @param Function callback (optional) A function to be executed whenever the animation completes.
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.fn.Shake = function (times, callback) {
	return this.queue('interfaceFX',function(){
		if (!jQuery.fxCheckTag(this)) {
			jQuery.dequeue(this, 'interfaceFX');
			return false;
		}
		var e = new jQuery.fx.Shake(this, times, callback);
		e.shake();
	});
};
jQuery.fx.Shake = function (e, times, callback)
{
	var z = this;
	z.el = jQuery(e);
	z.el.show();
	z.times = parseInt(times)||3;
	z.callback = callback;
	z.cnt = 1;
	z.oldStyle = {};
	z.oldStyle.position = z.el.css('position');
	z.oldStyle.top = parseInt(z.el.css('top'))||0;
	z.oldStyle.left = parseInt(z.el.css('left'))||0;
	
	if (z.oldStyle.position != 'relative' && z.oldStyle.position != 'absolute') {
		z.el.css('position', 'relative');
	}
	
	z.shake = function ()
	{
		z.cnt ++;
		
		z.e = new jQuery.fx(
			z.el.get(0), 
			{
				duration: 60,
				complete : function ()
				{
					z.e = new jQuery.fx(
						z.el.get(0), 
						 {
							 duration: 60,
							 complete : function ()
							 {
								z.e = new jQuery.fx(
									e,
									{
										duration: 60, 
										complete: function(){
											if (z.cnt <= z.times)
												z.shake();
											else {
												z.el.css('position', z.oldStyle.position).css('top', z.oldStyle.top + 'px').css('left', z.oldStyle.left + 'px');
												jQuery.dequeue(z.el.get(0), 'interfaceFX');
												if (z.callback && z.callback.constructor == Function) {
													z.callback.apply(z.el.get(0));
												}
											}
										}
									},
									'left'
								);
								z.e.custom (z.oldStyle.left-20, z.oldStyle.left);
							 }
						},
						'left'
					);
					z.e.custom (z.oldStyle.left+20, z.oldStyle.left-20);
				}
			},
			'left'
		);
		z.e.custom (z.oldStyle.left, z.oldStyle.left+20);
	};
		
};/**
 * Interface Elements for jQuery
 * FX - slide
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Slides the element
 */
jQuery.fn.extend(
	{
		/**
		 * @name SlideInUp
		 * @description slides the element in up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideInUp : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'up', 'in', easing);
			});
		},
		
		/**
		 * @name SlideOutUp
		 * @description slides the element out up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideOutUp : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'up', 'out', easing);
			});
		},
		
		/**
		 * @name SlideToggleUp
		 * @description slides the element in/out up
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideToggleUp : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'up', 'toggle', easing);
			});
		},
		
		/**
		 * @name SlideInDown
		 * @description slides the element in down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideInDown : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'down', 'in', easing);
			});
		},
		
		/**
		 * @name SlideOutDown
		 * @description slides the element out down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideOutDown : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'down', 'out', easing);
			});
		},
		
		/**
		 * @name SlideToggleDown
		 * @description slides the element in/out down
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideToggleDown : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'down', 'toggle', easing);
			});
		},
		
		/**
		 * @name SlideInLeft
		 * @description slides the element in left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideInLeft : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'left', 'in', easing);
			});
		},
		
		/**
		 * @name SlideOutLeft
		 * @description slides the element out left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideOutLeft :  function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'left', 'out', easing);
			});
		},
		
		/**
		 * @name SlideToggleLeft
		 * @description slides the element in/out left
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideToggleLeft : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'left', 'toggle', easing);
			});
		},
		
		/**
		 * @name SlideInRight
		 * @description slides the element in right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideInRight : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'right', 'in', easing);
			});
		},
		
		/**
		 * @name SlideOutRight
		 * @description slides the element out right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideOutRight : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'right', 'out', easing);
			});
		},
		
		/**
		 * @name SlideToggleRight
		 * @description slides the element in/out right
		 * @param Mixed speed animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
		 * @param Function callback (optional) A function to be executed whenever the animation completes.
		 * @param String easing (optional) The name of the easing effect that you want to use.
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SlideToggleRight : function (speed,callback, easing)
		{
			return this.queue('interfaceFX', function(){
				new jQuery.fx.slide(this, speed, callback, 'right', 'toggle', easing);
			});
		}
	}
);

jQuery.fx.slide = function(e, speed, callback, direction, type, easing)
{
	if (!jQuery.fxCheckTag(e)) {
		jQuery.dequeue(e, 'interfaceFX');
		return false;
	}
	var z = this;
	z.el = jQuery(e);
	z.easing = typeof callback == 'string' ? callback : easing||null;
	z.callback = typeof callback == 'function' ? callback : null;
	if ( type == 'toggle') {
		type = z.el.css('display') == 'none' ? 'in' : 'out';
	}
	if (!e.ifxFirstDisplay)
		e.ifxFirstDisplay = z.el.css('display');
	z.el.show();
	
	z.speed = speed;
	z.fx = jQuery.fx.buildWrapper(e);
	
	z.type = type;
	z.direction = direction;
	z.complete = function()
	{
		if(z.type == 'out')
			z.el.css('visibility', 'hidden');
		jQuery.fx.destroyWrapper(z.fx.wrapper.get(0), z.fx.oldStyle);
		if(z.type == 'in'){
			z.el.css('display', z.el.get(0).ifxFirstDisplay == 'none' ? 'block' : z.el.get(0).ifxFirstDisplay);
		} else {
			z.el.css('display', 'none');
			z.el.css('visibility', 'visible');
		}
		if (z.callback && z.callback.constructor == Function) {
			z.callback.apply(z.el.get(0));
		}
		jQuery.dequeue(z.el.get(0), 'interfaceFX');
	};
	switch (z.direction) {
		case 'up':
			z.ef = new jQuery.fx(
				z.el.get(0), 
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'top'
			);
			z.efx = new jQuery.fx(
				z.fx.wrapper.get(0), 
				jQuery.speed(
					z.speed,
					z.easing
				),
				'height'
			);
			if (z.type == 'in') {
				z.ef.custom (-z.fx.oldStyle.sizes.hb, 0);
				z.efx.custom(0, z.fx.oldStyle.sizes.hb);
			} else {
				z.ef.custom (0, -z.fx.oldStyle.sizes.hb);
				z.efx.custom (z.fx.oldStyle.sizes.hb, 0);
			}
		break;
		case 'down':
			z.ef = new jQuery.fx(
				z.el.get(0), 
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'top'
			);
			if (z.type == 'in') {
				z.ef.custom (z.fx.oldStyle.sizes.hb, 0);
			} else {
				z.ef.custom (0, z.fx.oldStyle.sizes.hb);
			}
		break;
		case 'left':
			z.ef = new jQuery.fx(
				z.el.get(0), 
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'left'
			);
			z.efx = new jQuery.fx(
				z.fx.wrapper.get(0), 
				jQuery.speed(
					z.speed,
					z.easing
				),
				'width'
			);
			if (z.type == 'in') {
				z.ef.custom (-z.fx.oldStyle.sizes.wb, 0);
				z.efx.custom (0, z.fx.oldStyle.sizes.wb);
			} else {
				z.ef.custom (0, -z.fx.oldStyle.sizes.wb);
				z.efx.custom (z.fx.oldStyle.sizes.wb, 0);
			}
		break;
		case 'right':
			z.ef = new jQuery.fx(
				z.el.get(0), 
				jQuery.speed(
					z.speed,
					z.easing,
					z.complete
				),
				'left'
			);
			if (z.type == 'in') {
				z.ef.custom (z.fx.oldStyle.sizes.wb, 0);
			} else {
				z.ef.custom (0, z.fx.oldStyle.sizes.wb);
			}
		break;
	}
};
/**
 * Interface Elements for jQuery
 * FX - transfer
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

jQuery.transferHelper = null;
/**
 * 
 * @name TransferTo
 * @description Animates an new build element to simulate a transfer action from one element to other
 * @param Hash hash A hash of parameters
 * @option Mixed to DOMElement or element ID to transfer to
 * @option String className CSS class to apply to transfer element
 * @option String duration animation speed, integer for miliseconds, string ['slow' | 'normal' | 'fast']
 * @option Function callback (optional) A function to be executed whenever the animation completes.
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.fn.TransferTo = function(o)
{
	return this.queue('interfaceFX', function(){
		new jQuery.fx.itransferTo(this, o);
	});
};
jQuery.fx.itransferTo = function(e, o)
{
	
	if(jQuery.transferHelper == null)
	{
		jQuery('body', document).append('<div id="transferHelper"></div>');
		jQuery.transferHelper = jQuery('#transferHelper');
	}
	jQuery.transferHelper.css('display', 'block').css('position', 'absolute');
	
	var z = this;
	z.el = jQuery(e);
	if(!o || !o.to) {
		return;
	}
	
	if (o.to.constructor == String && document.getElementById(o.to)) {
		o.to = document.getElementById(o.to);
	} else if ( !o.to.childNodes ) {
		return;
	}
	
	if (!o.duration) {
		o.duration = 500;
	}
	z.duration = o.duration;
	z.to = o.to;
	z.classname = o.className;
	z.complete = o.complete;
	if (z.classname) {
		jQuery.transferHelper.addClass(z.classname);
	}
	z.diffWidth = 0;
	z.diffHeight = 0;
	
	if(jQuery.boxModel) {
		z.diffWidth = (parseInt(jQuery.transferHelper.css('borderLeftWidth')) || 0 )
					+ (parseInt(jQuery.transferHelper.css('borderRightWidth')) || 0)
					+ (parseInt(jQuery.transferHelper.css('paddingLeft')) || 0)
					+ (parseInt(jQuery.transferHelper.css('paddingRight')) || 0);
		z.diffHeight = (parseInt(jQuery.transferHelper.css('borderTopWidth')) || 0 )
					+ (parseInt(jQuery.transferHelper.css('borderBottomWidth')) || 0)
					+ (parseInt(jQuery.transferHelper.css('paddingTop')) || 0)
					+ (parseInt(jQuery.transferHelper.css('paddingBottom')) || 0);
	}
	z.start = jQuery.extend(
		jQuery.iUtil.getPosition(z.el.get(0)),
		jQuery.iUtil.getSize(z.el.get(0))
	);
	z.end = jQuery.extend(
		jQuery.iUtil.getPosition(z.to),
		jQuery.iUtil.getSize(z.to)
	);
	z.start.wb -= z.diffWidth;
	z.start.hb -= z.diffHeight;
	z.end.wb -= z.diffWidth;
	z.end.hb -= z.diffHeight;
	z.callback = o.complete;

	// Execute the transfer
	jQuery.transferHelper
		.css('width', z.start.wb + 'px')
		.css('height', z.start.hb + 'px')
		.css('top', z.start.y + 'px')
		.css('left', z.start.x + 'px')
		.animate(
			{
				top: z.end.y,
				left: z.end.x,
				width: z.end.wb,
				height: z.end.hb
			},
			z.duration,
			function()
			{
				// Set correct classname
				if(z.classname)
					jQuery.transferHelper.removeClass(z.classname);
				jQuery.transferHelper.css('display', 'none');
	
				// Callback
				if (z.complete && z.complete.constructor == Function) {
					z.complete.apply(z.el.get(0), [z.to]);
				}
				// Done
				jQuery.dequeue(z.el.get(0), 'interfaceFX');
			}
		);
};/**
 * Interface Elements for jQuery
 * ImageBox
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */

/**
 * This a jQuery equivalent for Lightbox2. Alternative to image popups that will display images in an overlay. All links that have attribute 'rel' starting with 'imagebox' and link to an image will display the image inside the page. Galleries can by build buy giving the value 'imagebox-galname' to attribute 'rel'. Attribute 'title' will be used as caption.
 * Keyboard navigation:
 *  -  next image: arrow right, page down, 'n' key, space
 *  -  previous image: arrow left, page up, 'p' key, backspace
 *  -  close: escape
 *
 * CSS
 *	#ImageBoxOverlay
 *	{
 *		background-color: #000;
 *	}
 *	#ImageBoxCaption
 *	{
 *		background-color: #F4F4EC;
 *	}
 *	#ImageBoxContainer
 *	{
 *		width: 250px;
 *		height: 250px;
 *		background-color: #F4F4EC;
 *	}
 *	#ImageBoxCaptionText
 *	{
 *		font-weight: bold;
 *		padding-bottom: 5px;
 *		font-size: 13px;
 *		color: #000;
 *	}
 *	#ImageBoxCaptionImages
 *	{
 *		margin: 0;
 *	}
 *	#ImageBoxNextImage
 *	{
 *		background-image: url(images/imagebox/spacer.gif);
 *		background-color: transparent;
 *	}
 *	#ImageBoxPrevImage
 *	{
 *		background-image: url(images/imagebox/spacer.gif);
 *		background-color: transparent;
 *	}
 *	#ImageBoxNextImage:hover
 *	{
 *		background-image: url(images/imagebox/next_image.jpg);
 *		background-repeat:	no-repeat;
 *		background-position: right top;
 *	}
 *	#ImageBoxPrevImage:hover
 *	{
 *		background-image: url(images/imagebox/prev_image.jpg);
 *		background-repeat:	no-repeat;
 *		background-position: left bottom;
 *	}
 * 
 * @name Imagebox
 * @description This a jQuery equivalent for Lightbox2. Alternative to image popups that will display images in an overlay. All links that have attribute 'rel' starting with 'imagebox' and link to an image will display the image inside the page. Galleries can by build buy giving the value 'imagebox-galname' to attribute 'rel'. Attribute 'title' will be used as caption.
 * @param Hash hash A hash of parameters
 * @option Integer border border width
 * @option String loaderSRC path to loading image
 * @option String closeHTML path to close overlay image
 * @option Float overlayOpacity opacity for overlay
 * @option String textImage when a galalry it is build then the iteration is displayed
 * @option String textImageFrom when a galalry it is build then the iteration is displayed
 * @option Integer fadeDuration fade duration in miliseconds
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.ImageBox = {
	options : {
		border				: 10,
		loaderSRC			: 'images/loading.gif',
		closeHTML			: '<img src="images/close.jpg" />',
		overlayOpacity		: 0.8,
		textImage			: 'Showing image',
		textImageFrom		: 'from',
		fadeDuration		: 400
	},
	imageLoaded : false,
	firstResize : false,
	currentRel : null,
	animationInProgress : false,
	opened : false,
	
	keyPressed : function(event)
	{
		if(!jQuery.ImageBox.opened || jQuery.ImageBox.animationInProgress)
			return;
		var pressedKey = event.charCode || event.keyCode || -1;
		switch (pressedKey)
		{
			//end
			case 35:
				if (jQuery.ImageBox.currentRel)
					jQuery.ImageBox.start(null, jQuery('a[@rel=' + jQuery.ImageBox.currentRel+ ']:last').get(0));
			break;
			//home
			case 36:
				if (jQuery.ImageBox.currentRel)
					jQuery.ImageBox.start(null, jQuery('a[@rel=' + jQuery.ImageBox.currentRel+ ']:first').get(0));
			break;
			//left
			case 37:
			//backspace
			case 8:
			//page up
			case 33:
			//p
			case 80:
			case 112:
				var prevEl = jQuery('#ImageBoxPrevImage');
				if(prevEl.get(0).onclick != null) {
					prevEl.get(0).onclick.apply(prevEl.get(0));
				}
			break;
			//up
			case 38:
			break;
			//right
			case 39:
			//page down
			case 34:
			//space
			case 32:
			//n
			case 110:
			case 78:
				var nextEl = jQuery('#ImageBoxNextImage');
				if(nextEl.get(0).onclick != null) {
					nextEl.get(0).onclick.apply(nextEl.get(0));
				}
			break;
			//down;
			case 40:
			break;
			//escape
			case 27:
				jQuery.ImageBox.hideImage();
			break;
		}
	},
	
	init : function(options)
	{
		if (options)
			jQuery.extend(jQuery.ImageBox.options, options);
		if (window.event) {
			jQuery('body',document).bind('keyup', jQuery.ImageBox.keyPressed);
		} else {
			jQuery(document).bind('keyup', jQuery.ImageBox.keyPressed);
		}
		jQuery('a').each(
			function()
			{
				el 				= jQuery(this);
				relAttr 		= el.attr('rel')||'';
				hrefAttr 		= el.attr('href')||'';
				imageTypes 		= /\.jpg|\.jpeg|\.png|\.gif|\.bmp/g;
				if (hrefAttr.toLowerCase().match(imageTypes) != null && relAttr.toLowerCase().indexOf('imagebox') == 0) {
					el.bind('click', jQuery.ImageBox.start);
				}
			}
		);
		if (jQuery.browser.msie) {
			iframe = document.createElement('iframe');
			jQuery(iframe)
				.attr(
					{
						id			: 'ImageBoxIframe',
						src			: 'javascript:false;',
						frameborder	: 'no',
						scrolling	: 'no'
					}
				)
				.css (
					{
						display		: 'none',
						position	: 'absolute',
						top			: '0',
						left		: '0',
						filter		: 'progid:DXImageTransform.Microsoft.Alpha(opacity=0)'
					}
				);
			jQuery('body').append(iframe);
		}
		
		overlay	= document.createElement('div');
		jQuery(overlay)
			.attr('id', 'ImageBoxOverlay')
			.css(
				{
					position	: 'absolute',
					display		: 'none',
					top			: '0',
					left		: '0',
					opacity		: 0
				}
			)
			.append(document.createTextNode(' '))
			.bind('click', jQuery.ImageBox.hideImage);
		
		captionText = document.createElement('div');
		jQuery(captionText)
			.attr('id', 'ImageBoxCaptionText')
			.css(
				{
					paddingLeft		: jQuery.ImageBox.options.border + 'px'
				}
			)
			.append(document.createTextNode(' '));
			
		captionImages = document.createElement('div');
		jQuery(captionImages)
			.attr('id', 'ImageBoxCaptionImages')
			.css(
				{
					paddingLeft		: jQuery.ImageBox.options.border + 'px',
					paddingBottom	: jQuery.ImageBox.options.border + 'px'
				}
			)
			.append(document.createTextNode(' '));
			
		closeEl = document.createElement('a');
		jQuery(closeEl)
			.attr(
				{
					id			: 'ImageBoxClose',
					href		: '#'
				}
			)
			.css(
				{
					position	: 'absolute',
					right		: jQuery.ImageBox.options.border + 'px',
					top			: '0'
				}
			)
			.append(jQuery.ImageBox.options.closeHTML)
			.bind('click', jQuery.ImageBox.hideImage);
			
		captionEl = document.createElement('div');
		jQuery(captionEl)
			.attr('id', 'ImageBoxCaption')
			.css(
				{
					position	: 'relative',
					textAlign	: 'left',
					margin		: '0 auto',
					zIndex		: 1
				}
			)
			.append(captionText)
			.append(captionImages)
			.append(closeEl);
		
		loader = document.createElement('img');
		loader.src = jQuery.ImageBox.options.loaderSRC;
		jQuery(loader)
			.attr('id', 'ImageBoxLoader')
			.css(
				{
					position	: 'absolute'
				}
			);
			
		prevImage = document.createElement('a');
		jQuery(prevImage)
			.attr(
				{
					id			: 'ImageBoxPrevImage',
					href		: '#'
				}
			)
			.css(
				{
					position		: 'absolute',
					display			: 'none',
					overflow		: 'hidden',
					textDecoration	: 'none'
				}
			)
			.append(document.createTextNode(' '));
			
		nextImage = document.createElement('a');
		jQuery(nextImage)
			.attr(
				{
					id			: 'ImageBoxNextImage',
					href		: '#'
				}
			)
			.css(
				{
					position		: 'absolute',
					overflow		: 'hidden',
					textDecoration	: 'none'
				}
			)
			.append(document.createTextNode(' '));
		
		container = document.createElement('div');
		jQuery(container)
			.attr('id', 'ImageBoxContainer')
			.css(
				{
					display		: 'none',
					position	: 'relative',
					overflow	: 'hidden',
					textAlign	: 'left',
					margin		: '0 auto',
					top			: '0',
					left		: '0',
					zIndex		: 2
				}
			)
			.append([loader, prevImage, nextImage]);
		
		outerContainer = document.createElement('div');
		jQuery(outerContainer)
			.attr('id', 'ImageBoxOuterContainer')
			.css(
				{
					display		: 'none',
					position	: 'absolute',
					overflow	: 'hidden',
					top			: '0',
					left		: '0',
					textAlign	: 'center',
					backgroundColor : 'transparent',
					lineHeigt	: '0'
				}
			)
			.append([container,captionEl]);
		
		jQuery('body')
			.append(overlay)
			.append(outerContainer);
	},
	
	start : function(e, elm)
	{
		el = elm ? jQuery(elm) : jQuery(this);
		linkRel =  el.attr('rel');
		var totalImages, iteration, prevImage, nextImage;
		if (linkRel != 'imagebox') {
			jQuery.ImageBox.currentRel = linkRel;
			gallery = jQuery('a[@rel=' + linkRel + ']');
			totalImages = gallery.size();
			iteration = gallery.index(elm ? elm : this);
			prevImage = gallery.get(iteration - 1);
			nextImage = gallery.get(iteration + 1);
		}
		imageSrc =  el.attr('href');
		captionText = el.attr('title');
		pageSize = jQuery.iUtil.getScroll();
		overlay = jQuery('#ImageBoxOverlay');
		if (!jQuery.ImageBox.opened) {
			jQuery.ImageBox.opened = true;
			if (jQuery.browser.msie) {
				jQuery('#ImageBoxIframe')
					.css ('height', Math.max(pageSize.ih,pageSize.h) + 'px')
					.css ('width', Math.max(pageSize.iw,pageSize.w) + 'px')
					.show();
			}
			overlay
				.css ('height', Math.max(pageSize.ih,pageSize.h) + 'px')
				.css ('width', Math.max(pageSize.iw,pageSize.w) + 'px')
				.show()
				.fadeTo( 
					300,
					jQuery.ImageBox.options.overlayOpacity,
					function()
					{
						jQuery.ImageBox.loadImage(
							imageSrc, 
							captionText, 
							pageSize, 
							totalImages, 
							iteration,
							prevImage,
							nextImage
						);
					}
				);
			jQuery('#ImageBoxOuterContainer').css ('width', Math.max(pageSize.iw,pageSize.w) + 'px');
		} else {
			jQuery('#ImageBoxPrevImage').get(0).onclick = null;
			jQuery('#ImageBoxNextImage').get(0).onclick = null;
			jQuery.ImageBox.loadImage(
				imageSrc, 
				captionText, 
				pageSize, 
				totalImages, 
				iteration,
				prevImage,
				nextImage
			);
		}
		return false;
	},
		
	loadImage : function(imageSrc, captiontext, pageSize, totalImages, iteration, prevImage, nextImage)
	{
		jQuery('#ImageBoxCurrentImage').remove();
		prevImageEl = jQuery('#ImageBoxPrevImage');
		prevImageEl.hide();
		nextImageEl = jQuery('#ImageBoxNextImage');
		nextImageEl.hide();
		loader = jQuery('#ImageBoxLoader');
		container = jQuery('#ImageBoxContainer');
		outerContainer = jQuery('#ImageBoxOuterContainer');
		captionEl = jQuery('#ImageBoxCaption').css('visibility', 'hidden');
		jQuery('#ImageBoxCaptionText').html(captionText);
		jQuery.ImageBox.animationInProgress = true;
		if (totalImages)
			jQuery('#ImageBoxCaptionImages').html(
				jQuery.ImageBox.options.textImage 
				+ ' ' + (iteration + 1) + ' '
				+ jQuery.ImageBox.options.textImageFrom  
				+ ' ' + totalImages
			);
		if (prevImage) {
			prevImageEl.get(0).onclick = function()
			{
				this.blur();
				jQuery.ImageBox.start(null, prevImage);
				return false;
			};
		}
		if (nextImage) {
			nextImageEl.get(0).onclick =function()
			{
				this.blur();
				jQuery.ImageBox.start(null, nextImage);
				return false;
			};
		}
		loader.show();
		containerSize = jQuery.iUtil.getSize(container.get(0));
		containerW = Math.max(containerSize.wb, loader.get(0).width + jQuery.ImageBox.options.border * 2);
		containerH = Math.max(containerSize.hb, loader.get(0).height + jQuery.ImageBox.options.border * 2);
		loader
			.css(
				{
					left	: (containerW - loader.get(0).width)/2 + 'px',
					top		: (containerH - loader.get(0).height)/2 + 'px'
				}
			);
		container
			.css(
				{
					width	: containerW + 'px',
					height	: containerH + 'px'
				}
			)
			.show();
		clientSize = jQuery.iUtil.getClient();
		outerContainer
			.css('top', pageSize.t +  (clientSize.h / 15) + 'px');
		if (outerContainer.css('display') == 'none') {
			outerContainer
				.show()
				.fadeIn(
					jQuery.ImageBox.options.fadeDuration
				);
		}
		imageEl = new Image;
		jQuery(imageEl)
			.attr('id', 'ImageBoxCurrentImage')
			.bind('load', 
			function()
			{
				containerW = imageEl.width + jQuery.ImageBox.options.border * 2;
				containerH = imageEl.height + jQuery.ImageBox.options.border * 2;
				loader.hide();
				container.animate(
					{
						height		: containerH
					},
					containerSize.hb != containerH ? jQuery.ImageBox.options.fadeDuration : 1,
					function()
					{
						container.animate(
							{
								width		: containerW
							},
							containerSize.wb != containerW ? jQuery.ImageBox.options.fadeDuration : 1,
							function()
							{
								container.prepend(imageEl);
								jQuery(imageEl)
									.css(
										{
											position	: 'absolute',
											left		: jQuery.ImageBox.options.border + 'px',
											top			: jQuery.ImageBox.options.border + 'px'
										}
									)
									.fadeIn(
										jQuery.ImageBox.options.fadeDuration,
										function()
										{
											captionSize = jQuery.iUtil.getSize(captionEl.get(0));
											if (prevImage) {
												prevImageEl
													.css(
														{
															left	: jQuery.ImageBox.options.border + 'px',
															top		: jQuery.ImageBox.options.border + 'px',
															width	: containerW/2 - jQuery.ImageBox.options.border * 3 + 'px',
															height	: containerH - jQuery.ImageBox.options.border * 2 + 'px'
														}
													)
													.show();
											}
											if (nextImage) {
												nextImageEl
													.css(
														{
															left	: containerW/2 + jQuery.ImageBox.options.border * 2 + 'px',
															top		: jQuery.ImageBox.options.border + 'px',
															width	: containerW/2 - jQuery.ImageBox.options.border * 3 + 'px',
															height	: containerH - jQuery.ImageBox.options.border * 2 + 'px'
														}
													)
													.show();
											}
											captionEl
												.css(
													{
														width		: containerW + 'px',
														top			: - captionSize.hb + 'px',
														visibility	: 'visible'
													}
												)
												.animate(
													{
														top		: -1
													},
													jQuery.ImageBox.options.fadeDuration,
													function()
													{
														jQuery.ImageBox.animationInProgress = false;
													}
												);
										}
									);
							}
						);
					}
				);
			}
		);
		imageEl.src = imageSrc;
			
	},
	
	hideImage : function()
	{
		jQuery('#ImageBoxCurrentImage').remove();
		jQuery('#ImageBoxOuterContainer').hide();
		jQuery('#ImageBoxCaption').css('visibility', 'hidden');
		jQuery('#ImageBoxOverlay').fadeTo(
			300, 
			0, 
			function(){
				jQuery(this).hide();
				if (jQuery.browser.msie) {
					jQuery('#ImageBoxIframe').hide();
				}
			}
		);
		jQuery('#ImageBoxPrevImage').get(0).onclick = null;
		jQuery('#ImageBoxNextImage').get(0).onclick = null;
		jQuery.ImageBox.currentRel = null;
		jQuery.ImageBox.opened = false;
		jQuery.ImageBox.animationInProgress = false;
		return false;
	}
};/**
 * Interface Elements for jQuery
 * Resizable
 *
 * http://interface.eyecon.ro
 *
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 *
 */

jQuery.iResize = {
	resizeElement: null,
	resizeDirection: null,
	dragged: null,
	pointer: null,
	sizes: null,
	position: null,
	/**
	 * internal: Start function
	 */
	startDrag: function(e) {
		jQuery.iResize.dragged = (this.dragEl) ? this.dragEl: this;
		jQuery.iResize.pointer = jQuery.iUtil.getPointer(e);

		// Save original size
		jQuery.iResize.sizes = {
			width: parseInt(jQuery(jQuery.iResize.dragged).css('width')) || 0,
			height: parseInt(jQuery(jQuery.iResize.dragged).css('height')) || 0
		};

		// Save original position
		jQuery.iResize.position = {
			top: parseInt(jQuery(jQuery.iResize.dragged).css('top')) || 0,
			left: parseInt(jQuery(jQuery.iResize.dragged).css('left')) || 0
		};

		// Assign event handlers
		jQuery(document)
			.bind('mousemove', jQuery.iResize.moveDrag)
			.bind('mouseup', jQuery.iResize.stopDrag);

		// Callback?
		if (typeof jQuery.iResize.dragged.resizeOptions.onDragStart === 'function') {
			jQuery.iResize.dragged.resizeOptions.onDragStart.apply(jQuery.iResize.dragged);
		}
		return false;
	},
	/**
	 * internal: Stop function
	 */
	stopDrag: function(e) {
		// Unbind event handlers
		jQuery(document)
			.unbind('mousemove', jQuery.iResize.moveDrag)
			.unbind('mouseup', jQuery.iResize.stopDrag);

		// Callback?
		if (typeof jQuery.iResize.dragged.resizeOptions.onDragStop === 'function') {
			jQuery.iResize.dragged.resizeOptions.onDragStop.apply(jQuery.iResize.dragged);
		}

		// Remove dragged element
		jQuery.iResize.dragged = null;
	},
	/**
	 * internal: Move function
	 */
	moveDrag: function(e) {
		if (!jQuery.iResize.dragged) {
			return;
		}

		pointer = jQuery.iUtil.getPointer(e);

		// Calculate new positions
		newTop = jQuery.iResize.position.top - jQuery.iResize.pointer.y + pointer.y;
		newLeft = jQuery.iResize.position.left - jQuery.iResize.pointer.x + pointer.x;
		newTop = Math.max(
						Math.min(newTop, jQuery.iResize.dragged.resizeOptions.maxBottom - jQuery.iResize.sizes.height),
						jQuery.iResize.dragged.resizeOptions.minTop
					);
		newLeft = Math.max(
						Math.min(newLeft, jQuery.iResize.dragged.resizeOptions.maxRight- jQuery.iResize.sizes.width),
						jQuery.iResize.dragged.resizeOptions.minLeft
					);

		// Callback
		if (typeof jQuery.iResize.dragged.resizeOptions.onDrag === 'function') {
			var newPos = jQuery.iResize.dragged.resizeOptions.onDrag.apply(jQuery.iResize.dragged, [newLeft, newTop]);
			if (typeof newPos == 'array' && newPos.length == 2) {
				newLeft = newPos[0];
				newTop = newPos[1];
			}
		}

		// Update the element
		jQuery.iResize.dragged.style.top = newTop + 'px';
		jQuery.iResize.dragged.style.left = newLeft + 'px';

		return false;
	},
	start: function(e) {
		// Bind event handlers
		jQuery(document)
			.bind('mousemove', jQuery.iResize.move)
			.bind('mouseup', jQuery.iResize.stop);

		// Initialize resizable
		jQuery.iResize.resizeElement = this.resizeElement;
		jQuery.iResize.resizeDirection = this.resizeDirection;
		jQuery.iResize.pointer = jQuery.iUtil.getPointer(e);
		jQuery.iResize.sizes = {
				width: parseInt(jQuery(this.resizeElement).css('width'))||0,
				height: parseInt(jQuery(this.resizeElement).css('height'))||0
			};
		jQuery.iResize.position = {
				top: parseInt(jQuery(this.resizeElement).css('top'))||0,
				left: parseInt(jQuery(this.resizeElement).css('left'))||0
			};

		// Callback function
		if (jQuery.iResize.resizeElement.resizeOptions.onStart) {
			jQuery.iResize.resizeElement.resizeOptions.onStart.apply(jQuery.iResize.resizeElement, [this]);
		}

		return false;
	},
	stop: function() {
		// Unbind event handlers
		jQuery(document)
			.unbind('mousemove', jQuery.iResize.move)
			.unbind('mouseup', jQuery.iResize.stop);

		// Callback function
		if (jQuery.iResize.resizeElement.resizeOptions.onStop) {
			jQuery.iResize.resizeElement.resizeOptions.onStop.apply(jQuery.iResize.resizeElement, [jQuery.iResize.resizeDirection]);
		}

		// Unbind
		jQuery.iResize.resizeElement = null;
		jQuery.iResize.resizeDirection = null;
	},
	getWidth: function(dx, side) {
		return Math.min(
						Math.max(jQuery.iResize.sizes.width + dx * side, jQuery.iResize.resizeElement.resizeOptions.minWidth),
						jQuery.iResize.resizeElement.resizeOptions.maxWidth
					);
	},
	getHeight: function(dy, side) {
		return Math.min(
						Math.max(jQuery.iResize.sizes.height + dy * side, jQuery.iResize.resizeElement.resizeOptions.minHeight),
						jQuery.iResize.resizeElement.resizeOptions.maxHeight
					);
	},
	getHeightMinMax: function(height) {
		return Math.min(
						Math.max(height, jQuery.iResize.resizeElement.resizeOptions.minHeight),
						jQuery.iResize.resizeElement.resizeOptions.maxHeight
					);
	},
	move: function(e) {
		if (jQuery.iResize.resizeElement == null) {
			return;
		}

		pointer = jQuery.iUtil.getPointer(e);
		dx = pointer.x - jQuery.iResize.pointer.x;
		dy = pointer.y - jQuery.iResize.pointer.y;

		newSizes = {
				width: jQuery.iResize.sizes.width,
				height: jQuery.iResize.sizes.height
			};
		newPosition = {
				top: jQuery.iResize.position.top,
				left: jQuery.iResize.position.left
			};

		switch (jQuery.iResize.resizeDirection){
			case 'e':
				newSizes.width = jQuery.iResize.getWidth(dx,1);
				break;
			case 'se':
				newSizes.width = jQuery.iResize.getWidth(dx,1);
				newSizes.height = jQuery.iResize.getHeight(dy,1);
				break;
			case 'w':
				newSizes.width = jQuery.iResize.getWidth(dx,-1);
				newPosition.left = jQuery.iResize.position.left - newSizes.width + jQuery.iResize.sizes.width;
				break;
			case 'sw':
				newSizes.width = jQuery.iResize.getWidth(dx,-1);
				newPosition.left = jQuery.iResize.position.left - newSizes.width + jQuery.iResize.sizes.width;
				newSizes.height = jQuery.iResize.getHeight(dy,1);
				break;
			case 'nw':
				newSizes.height = jQuery.iResize.getHeight(dy,-1);
				newPosition.top = jQuery.iResize.position.top - newSizes.height + jQuery.iResize.sizes.height;
				newSizes.width = jQuery.iResize.getWidth(dx,-1);
				newPosition.left = jQuery.iResize.position.left - newSizes.width + jQuery.iResize.sizes.width;
				break;
			case 'n':
				newSizes.height = jQuery.iResize.getHeight(dy,-1);
				newPosition.top = jQuery.iResize.position.top - newSizes.height + jQuery.iResize.sizes.height;
				break;
			case 'ne':
				newSizes.height = jQuery.iResize.getHeight(dy,-1);
				newPosition.top = jQuery.iResize.position.top - newSizes.height + jQuery.iResize.sizes.height;
				newSizes.width = jQuery.iResize.getWidth(dx,1);
				break;
			case 's':
				newSizes.height = jQuery.iResize.getHeight(dy,1);
				break;
		}

		if (jQuery.iResize.resizeElement.resizeOptions.ratio) {
			if (jQuery.iResize.resizeDirection == 'n' || jQuery.iResize.resizeDirection == 's')
				nWidth = newSizes.height * jQuery.iResize.resizeElement.resizeOptions.ratio;
			else
				nWidth = newSizes.width;
			nHeight = jQuery.iResize.getHeightMinMax(nWidth * jQuery.iResize.resizeElement.resizeOptions.ratio);
			nWidth = nHeight / jQuery.iResize.resizeElement.resizeOptions.ratio;

			switch (jQuery.iResize.resizeDirection){
				case 'n':
				case 'nw':
				case 'ne':
					newPosition.top += newSizes.height - nHeight;
				break;
			}

			switch (jQuery.iResize.resizeDirection){
				case 'nw':
				case 'w':
				case 'sw':
					newPosition.left += newSizes.width - nWidth;
				break;
			}

			newSizes.height = nHeight;
			newSizes.width = nWidth;
		}

		if (newPosition.top < jQuery.iResize.resizeElement.resizeOptions.minTop) {
			nHeight = newSizes.height + newPosition.top - jQuery.iResize.resizeElement.resizeOptions.minTop;
			newPosition.top = jQuery.iResize.resizeElement.resizeOptions.minTop;

			if (jQuery.iResize.resizeElement.resizeOptions.ratio) {
				nWidth = nHeight / jQuery.iResize.resizeElement.resizeOptions.ratio;
				switch (jQuery.iResize.resizeDirection){
					case 'nw':
					case 'w':
					case 'sw':
						newPosition.left += newSizes.width - nWidth;
					break;
				}
				newSizes.width = nWidth;
			}
			newSizes.height = nHeight;
		}

		if (newPosition.left < jQuery.iResize.resizeElement.resizeOptions.minLeft ) {
			nWidth = newSizes.width + newPosition.left - jQuery.iResize.resizeElement.resizeOptions.minLeft;
			newPosition.left = jQuery.iResize.resizeElement.resizeOptions.minLeft;

			if (jQuery.iResize.resizeElement.resizeOptions.ratio) {
				nHeight = nWidth * jQuery.iResize.resizeElement.resizeOptions.ratio;
				switch (jQuery.iResize.resizeDirection){
					case 'n':
					case 'nw':
					case 'ne':
						newPosition.top += newSizes.height - nHeight;
					break;
				}
				newSizes.height = nHeight;
			}
			newSizes.width = nWidth;
		}

		if (newPosition.top + newSizes.height > jQuery.iResize.resizeElement.resizeOptions.maxBottom) {
			newSizes.height = jQuery.iResize.resizeElement.resizeOptions.maxBottom - newPosition.top;
			if (jQuery.iResize.resizeElement.resizeOptions.ratio) {
				newSizes.width = newSizes.height / jQuery.iResize.resizeElement.resizeOptions.ratio;
			}

		}

		if (newPosition.left + newSizes.width > jQuery.iResize.resizeElement.resizeOptions.maxRight) {
			newSizes.width = jQuery.iResize.resizeElement.resizeOptions.maxRight - newPosition.left;
			if (jQuery.iResize.resizeElement.resizeOptions.ratio) {
				newSizes.height = newSizes.width * jQuery.iResize.resizeElement.resizeOptions.ratio;
			}

		}

		var newDimensions = false;
		if (jQuery.iResize.resizeElement.resizeOptions.onResize) {
			newDimensions = jQuery.iResize.resizeElement.resizeOptions.onResize.apply( jQuery.iResize.resizeElement, [ newSizes, newPosition ] );
			if (newDimensions) {
				if (newDimensions.sizes) {
					jQuery.extend(newSizes, newDimensions.sizes);
				}

				if (newDimensions.position) {
					jQuery.extend(newPosition, newDimensions.position);
				}
			}
		}
			elS = jQuery.iResize.resizeElement.style;
			elS.left = newPosition.left + 'px';
			elS.top = newPosition.top + 'px';
			elS.width = newSizes.width + 'px';
			elS.height = newSizes.height + 'px';

		return false;
	},
	/**
	 * Builds the resizable
	 */
	build: function(options) {
		if (!options || !options.handlers || options.handlers.constructor != Object) {
			return;
		}

		return this.each(
			function() {
				var el = this;
				el.resizeOptions = options;
				el.resizeOptions.minWidth = options.minWidth || 10;
				el.resizeOptions.minHeight = options.minHeight || 10;
				el.resizeOptions.maxWidth = options.maxWidth || 3000;
				el.resizeOptions.maxHeight = options.maxHeight || 3000;
				el.resizeOptions.minTop = options.minTop || -1000;
				el.resizeOptions.minLeft = options.minLeft || -1000;
				el.resizeOptions.maxRight = options.maxRight || 3000;
				el.resizeOptions.maxBottom = options.maxBottom || 3000;
				elPosition = jQuery(el).css('position');
				if (!(elPosition == 'relative' || elPosition == 'absolute')) {
					el.style.position = 'relative';
				}

				directions = /n|ne|e|se|s|sw|w|nw/g;
				for (i in el.resizeOptions.handlers) {
					if (i.toLowerCase().match(directions) != null) {
						if (el.resizeOptions.handlers[i].constructor == String) {
							handle = jQuery(el.resizeOptions.handlers[i]);
							if (handle.size() > 0) {
								el.resizeOptions.handlers[i] = handle.get(0);
							}
						}

						if (el.resizeOptions.handlers[i].tagName) {
							el.resizeOptions.handlers[i].resizeElement = el;
							el.resizeOptions.handlers[i].resizeDirection = i;
							jQuery(el.resizeOptions.handlers[i]).bind('mousedown', jQuery.iResize.start);
						}
					}
				}

				if (el.resizeOptions.dragHandle) {
					if (typeof el.resizeOptions.dragHandle === 'string') {
						handleEl = jQuery(el.resizeOptions.dragHandle);
						if (handleEl.size() > 0) {
							handleEl.each(function() {
									this.dragEl = el;
								});
							handleEl.bind('mousedown', jQuery.iResize.startDrag);
						}
					} else if (el.resizeOptions.dragHandle == true) {
						jQuery(this).bind('mousedown', jQuery.iResize.startDrag);
					}
				}
			}
		);
	},
	/**
	 * Destroys the resizable
	 */
	destroy: function() {
		return this.each(
			function() {
				var el = this;

				// Unbind the handlers
				for (i in el.resizeOptions.handlers) {
					el.resizeOptions.handlers[i].resizeElement = null;
					el.resizeOptions.handlers[i].resizeDirection = null;
					jQuery(el.resizeOptions.handlers[i]).unbind('mousedown', jQuery.iResize.start);
				}

				// Remove the draghandle
				if (el.resizeOptions.dragHandle) {
					if (typeof el.resizeOptions.dragHandle === 'string') {
						handle = jQuery(el.resizeOptions.dragHandle);
						if (handle.size() > 0) {
							handle.unbind('mousedown', jQuery.iResize.startDrag);
						}
					} else if (el.resizeOptions.dragHandle == true) {
						jQuery(this).unbind('mousedown', jQuery.iResize.startDrag);
					}
				}

				// Reset the options
				el.resizeOptions = null;
			}
		);
	}
};


jQuery.fn.extend ({
		/**
		 * Create a resizable element with a number of advanced options including callback, dragging
		 * 
		 * @name Resizable
		 * @description Create a resizable element with a number of advanced options including callback, dragging
		 * @param Hash hash A hash of parameters. All parameters are optional.
		 * @option Hash handlers hash with keys for each resize direction (e, es, s, sw, w, nw, n) and value string selection
		 * @option Integer minWidth (optional) the minimum width that element can be resized to
		 * @option Integer maxWidth (optional) the maximum width that element can be resized to
		 * @option Integer minHeight (optional) the minimum height that element can be resized to
		 * @option Integer maxHeight (optional) the maximum height that element can be resized to
		 * @option Integer minTop (optional) the minmum top position to wich element can be moved to
		 * @option Integer minLeft (optional) the minmum left position to wich element can be moved to
		 * @option Integer maxRight (optional) the maximum right position to wich element can be moved to
		 * @option Integer maxBottom (optional) the maximum bottom position to wich element can be moved to
		 * @option Float ratio (optional) the ratio between width and height to constrain elements sizes to that ratio
		 * @option Mixed dragHandle (optional) true to make the element draggable, string selection for drag handle
		 * @option Function onDragStart (optional) A function to be executed whenever the dragging starts
		 * @option Function onDragStop (optional) A function to be executed whenever the dragging stops
		 * @option Function onDrag (optional) A function to be executed whenever the element is dragged
		 * @option Function onStart (optional) A function to be executed whenever the element starts to be resized
		 * @option Function onStop (optional) A function to be executed whenever the element stops to be resized
		 * @option Function onResize (optional) A function to be executed whenever the element is resized
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Resizable: jQuery.iResize.build,
		/**
		 * Destroy a resizable
		 * 
		 * @name ResizableDestroy
		 * @description Destroy a resizable
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		ResizableDestroy: jQuery.iResize.destroy
	});/**
 * Interface Elements for jQuery
 * Selectables
 *
 * http://interface.eyecon.ro
 *
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 *
 */

jQuery.selectHelper = null;
jQuery.selectKeyHelper = false;
jQuery.selectdrug = null;
jQuery.selectCurrent = [];	// For current selection
jQuery.selectKeyDown = function(e) {
	var pressedKey = e.charCode || e.keyCode || -1;
	if (pressedKey == 17 || pressedKey == 16) {
		jQuery.selectKeyHelper = true;
	}
};
jQuery.selectKeyUp = function(e) {
	jQuery.selectKeyHelper = false;
};
jQuery.selectstart = function(e) {
	this.f.pointer = jQuery.iUtil.getPointer(e);
	this.f.pos = jQuery.extend(
		jQuery.iUtil.getPosition(this), 
		jQuery.iUtil.getSize(this)
	);
	
	this.f.scr = jQuery.iUtil.getScroll(this);
	this.f.pointer.x -= this.f.pos.x;
	this.f.pointer.y -= this.f.pos.y;
	jQuery(this).append(jQuery.selectHelper.get(0));
	if (this.f.hc)
		jQuery.selectHelper.addClass(this.f.hc).css('display','block');
	jQuery.selectHelper.css(
		{
			display: 'block',
			width: '0px',
			height: '0px'
		}
	);
	if (this.f.o) {
		jQuery.selectHelper.css('opacity', this.f.o);
	}

	jQuery.selectdrug = this;
	jQuery.selectedone = false;
	jQuery.selectCurrent = [];	// For current selection state
	this.f.el.each(
		function ()
		{
			this.pos = {
				x: this.offsetLeft + (this.currentStyle && !jQuery.browser.opera ?parseInt(this.currentStyle.borderLeftWidth)||0:0) + (jQuery.selectdrug.scrollLeft||0), 
				y: this.offsetTop + (this.currentStyle && !jQuery.browser.opera ?parseInt(this.currentStyle.borderTopWidth)||0:0) + (jQuery.selectdrug.scrollTop||0),
				wb: this.offsetWidth,
				hb: this.offsetHeight
			};
			if (this.s == true) {
				if (jQuery.selectKeyHelper == false) {
					this.s = false;
					jQuery(this).removeClass(jQuery.selectdrug.f.sc);
				} else {
					jQuery.selectedone = true;

					// Save current state
					jQuery.selectCurrent[jQuery.selectCurrent.length] = jQuery.attr(this,'id');
				}
			}
		}
	);
	jQuery.selectcheck.apply(this, [e]);
	jQuery(document)
		.bind('mousemove', jQuery.selectcheck)
		.bind('mouseup', jQuery.selectstop);
	return false;
};
jQuery.selectcheck = function(e)
{
	if(!jQuery.selectdrug)
		return;
	jQuery.selectcheckApply.apply(jQuery.selectdrug, [e]);
};
jQuery.selectcheckApply = function(e)
{
	if(!jQuery.selectdrug)
		return;
	var pointer = jQuery.iUtil.getPointer(e);
	
	var scr = jQuery.iUtil.getScroll(jQuery.selectdrug);
	pointer.x += scr.l - this.f.scr.l - this.f.pos.x;
	pointer.y += scr.t - this.f.scr.t - this.f.pos.y;
	
	var sx = Math.min(pointer.x, this.f.pointer.x);
	var sw = Math.min(Math.abs(pointer.x - this.f.pointer.x), Math.abs(this.f.scr.w - sx));
	var sy = Math.min(pointer.y, this.f.pointer.y);
	var sh = Math.min(Math.abs(pointer.y - this.f.pointer.y), Math.abs(this.f.scr.h - sy));
	if (this.scrollTop > 0 && pointer.y - 20 < this.scrollTop) {
		var diff = Math.min(scr.t, 10);
		sy -= diff;
		sh += diff;
		this.scrollTop -= diff;
	} else if (this.scrollTop+ this.f.pos.h < this.f.scr.h && pointer.y + 20 > this.scrollTop + this.f.pos.h) {
		var diff = Math.min(this.f.scr.h - this.scrollTop, 10);
		this.scrollTop += diff;
		if (this.scrollTop != scr.t)
			sh += diff;
	}
	if (this.scrollLeft > 0 && pointer.x - 20 < this.scrollLeft) {
		var diff = Math.min(scr.l, 10);
		sx -= diff;
		sw += diff;
		this.scrollLeft -= diff;
	} else if (this.scrollLeft+ this.f.pos.w < this.f.scr.w && pointer.x + 20 > this.scrollLeft + this.f.pos.w) {
		var diff = Math.min(this.f.scr.w - this.scrollLeft, 10);
		this.scrollLeft += diff;
		if (this.scrollLeft != scr.l)
			sw += diff;
	}
	jQuery.selectHelper.css(
		{
			left:	sx + 'px',
			top:	sy + 'px',
			width:	sw + 'px',
			height:	sh + 'px'
		}
	);
	jQuery.selectHelper.l = sx + this.f.scr.l;
	jQuery.selectHelper.t = sy + this.f.scr.t;
	jQuery.selectHelper.r = jQuery.selectHelper.l + sw;
	jQuery.selectHelper.b = jQuery.selectHelper.t + sh;
	jQuery.selectedone = false;
	this.f.el.each(
		function () {
			// Locate the current element in the current selection
			iIndex = jQuery.selectCurrent.indexOf(jQuery.attr(this, 'id'));
			// In case we are currently OVER an item
			if (
				! ( this.pos.x > jQuery.selectHelper.r
				|| (this.pos.x + this.pos.wb) < jQuery.selectHelper.l
				|| this.pos.y > jQuery.selectHelper.b
				|| (this.pos.y + this.pos.hb) < jQuery.selectHelper.t
				)
			)
			{
				jQuery.selectedone = true;
				if (this.s != true) {
					this.s = true;
					jQuery(this).addClass(jQuery.selectdrug.f.sc);
				}

				// Check to see if this item was previously selected, if so, unselect it
				if (iIndex != -1) {
					this.s = false;
					jQuery(this).removeClass(jQuery.selectdrug.f.sc);
				}
			} else if (
						(this.s == true) &&
						(iIndex == -1)
					) {
				// If the item was marked as selected, but it was not selected when you started dragging unselect it.
				this.s = false;
				jQuery(this).removeClass(jQuery.selectdrug.f.sc);
			} else if (
						(!this.s) &&
						(jQuery.selectKeyHelper == true) &&
						(iIndex != -1)
					) {
				// Reselect the item if:
				// - we ARE multiselecting,
				// - dragged over an allready selected object (so it got unselected)
				// - But then dragged the selection out of it again.
				this.s = true;
				jQuery(this).addClass(jQuery.selectdrug.f.sc);
			}
		}
	);
	return false;
};
jQuery.selectstop = function(e)
{
	if(!jQuery.selectdrug)
		return;
	jQuery.selectstopApply.apply(jQuery.selectdrug, [e]);
};
jQuery.selectstopApply = function(e)
{
	jQuery(document)
		.unbind('mousemove', jQuery.selectcheck)
		.unbind('mouseup', jQuery.selectstop);
	if(!jQuery.selectdrug)
		return;
	jQuery.selectHelper.css('display','none');
	if (this.f.hc)
		jQuery.selectHelper.removeClass(this.f.hc);
	jQuery.selectdrug = false;
	jQuery('body').append(jQuery.selectHelper.get(0));
	//
	// In case we have selected some new items..
	if (jQuery.selectedone == true) {
		if (this.f.onselect)
			this.f.onselect(jQuery.Selectserialize(jQuery.attr(this,'id')));
	} else {
		if (this.f.onselectstop)
			this.f.onselectstop(jQuery.Selectserialize(jQuery.attr(this,'id')));
	}
	// Reset current selection
	jQuery.selectCurrent = [];
};

jQuery.Selectserialize = function(s)
{
	var h = '';
	var o = [];
	if (a = jQuery('#' + s)) {
		a.get(0).f.el.each(
			function ()
			{
				if (this.s == true) {
					if (h.length > 0) {
						h += '&';
					}
					h += s + '[]=' + jQuery.attr(this,'id');
					o[o.length] = jQuery.attr(this,'id');
				}
			}
		);
	}
	return {hash:h, o:o};
};
jQuery.fn.Selectable = function(o)
{
	if (!jQuery.selectHelper) {
		jQuery('body',document).append('<div id="selectHelper"></div>').bind('keydown', jQuery.selectKeyDown).bind('keyup', jQuery.selectKeyUp);
		jQuery.selectHelper = jQuery('#selectHelper');
		jQuery.selectHelper.css(
			{
				position:	'absolute',
				display:	'none'
			}
		);

		if (window.event) {
			jQuery('body',document).bind('keydown', jQuery.selectKeyDown).bind('keyup', jQuery.selectKeyUp);
		} else {
			jQuery(document).bind('keydown', jQuery.selectKeyDown).bind('keyup', jQuery.selectKeyUp);
		}
	}

    if (!o) {
		o = {};
	}
    return this.each(
		function()
		{
			if (this.isSelectable)
				return;
			this.isSelectable = true;
			this.f = {
				a : o.accept,
				o : o.opacity ? parseFloat(o.opacity) : false,
				sc : o.selectedclass ? o.selectedclass : false,
				hc : o.helperclass ? o.helperclass : false,
				onselect : o.onselect ? o.onselect : false,
				onselectstop : o.onselectstop ? o.onselectstop : false
			};
			this.f.el = jQuery('.' + o.accept);
			jQuery(this).bind('mousedown', jQuery.selectstart).css('position', 'relative');
		}
	);
};/**
 * Interface Elements for jQuery
 * Slider
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

jQuery.iSlider = {
	tabindex : 1,
	set : function (values)
	{
		var values = values;
		return this.each(
			function()
			{
				this.slideCfg.sliders.each(
					function (key) 
					{ 
						jQuery.iSlider.dragmoveBy(this,values[key]);
					}
				);
			}
		);
	},
	
	get : function()
	{
		var values = [];
		this.each(
			function(slider)
			{
				if (this.isSlider) {
					values[slider] = [];
					var elm = this;
					var sizes = jQuery.iUtil.getSize(this);
					this.slideCfg.sliders.each(
						function (key) 
						{
							var x = this.offsetLeft;
							var y = this.offsetTop;
							xproc = parseInt(x * 100 / (sizes.w - this.offsetWidth));
							yproc = parseInt(y * 100 / (sizes.h - this.offsetHeight));
							values[slider][key] = [xproc||0, yproc||0, x||0, y||0];
						}
					);
				}
			}
		);
		return values;
	},
	
	modifyContainer : function (elm)
	{
		elm.dragCfg.containerMaxx = elm.dragCfg.cont.w - elm.dragCfg.oC.wb;
		elm.dragCfg.containerMaxy = elm.dragCfg.cont.h - elm.dragCfg.oC.hb;
		if (elm.SliderContainer.slideCfg.restricted ) {
			next = elm.SliderContainer.slideCfg.sliders.get(elm.SliderIteration+1);
			if (next) {
				elm.dragCfg.cont.w = (parseInt(jQuery(next).css('left'))||0) + elm.dragCfg.oC.wb;
				elm.dragCfg.cont.h = (parseInt(jQuery(next).css('top'))||0) + elm.dragCfg.oC.hb;
			}
			prev = elm.SliderContainer.slideCfg.sliders.get(elm.SliderIteration-1);
			if (prev) {
				var prevLeft = parseInt(jQuery(prev).css('left'))||0;
				var prevTop = parseInt(jQuery(prev).css('left'))||0;
				elm.dragCfg.cont.x += prevLeft;
				elm.dragCfg.cont.y += prevTop;
				elm.dragCfg.cont.w -= prevLeft;
				elm.dragCfg.cont.h -= prevTop;
			}
		}
		elm.dragCfg.maxx = elm.dragCfg.cont.w - elm.dragCfg.oC.wb;
		elm.dragCfg.maxy = elm.dragCfg.cont.h - elm.dragCfg.oC.hb;
		if(elm.dragCfg.fractions) {
			elm.dragCfg.gx = ((elm.dragCfg.cont.w - elm.dragCfg.oC.wb)/elm.dragCfg.fractions) || 1;
			elm.dragCfg.gy = ((elm.dragCfg.cont.h - elm.dragCfg.oC.hb)/elm.dragCfg.fractions) || 1;
			elm.dragCfg.fracW = elm.dragCfg.maxx / elm.dragCfg.fractions;
			elm.dragCfg.fracH = elm.dragCfg.maxy / elm.dragCfg.fractions;
		}
		
		elm.dragCfg.cont.dx = elm.dragCfg.cont.x - elm.dragCfg.oR.x;
		elm.dragCfg.cont.dy = elm.dragCfg.cont.y - elm.dragCfg.oR.y;
		
		jQuery.iDrag.helper.css('cursor', 'default');
	},
	
	onSlide : function(elm, x, y)
	{
		if (elm.dragCfg.fractions) {
				xfrac = parseInt(x/elm.dragCfg.fracW);
				xproc = xfrac * 100 / elm.dragCfg.fractions;
				yfrac = parseInt(y/elm.dragCfg.fracH);
				yproc = yfrac * 100 / elm.dragCfg.fractions;
		} else {
			xproc = parseInt(x * 100 / elm.dragCfg.containerMaxx);
			yproc = parseInt(y * 100 / elm.dragCfg.containerMaxy);
		}
		elm.dragCfg.lastSi = [xproc||0, yproc||0, x||0, y||0];
		if (elm.dragCfg.onSlide)
			elm.dragCfg.onSlide.apply(elm, elm.dragCfg.lastSi);
	},
	
	dragmoveByKey : function (event)
	{
		pressedKey = event.charCode || event.keyCode || -1;
		
		switch (pressedKey)
		{
			//end
			case 35:
				jQuery.iSlider.dragmoveBy(this.dragElem, [2000, 2000] );
			break;
			//home
			case 36:
				jQuery.iSlider.dragmoveBy(this.dragElem, [-2000, -2000] );
			break;
			//left
			case 37:
				jQuery.iSlider.dragmoveBy(this.dragElem, [-this.dragElem.dragCfg.gx||-1, 0] );
			break;
			//up
			case 38:
				jQuery.iSlider.dragmoveBy(this.dragElem, [0, -this.dragElem.dragCfg.gy||-1] );
			break;
			//right
			case 39:
				jQuery.iSlider.dragmoveBy(this.dragElem, [this.dragElem.dragCfg.gx||1, 0] );
			break;
			//down;
			case 40:
				jQuery.iDrag.dragmoveBy(this.dragElem, [0, this.dragElem.dragCfg.gy||1] );
			break;
		}
	},
	
	dragmoveBy : function (elm, position) 
	{
		if (!elm.dragCfg) {
			return;
		}
		
		elm.dragCfg.oC = jQuery.extend(
			jQuery.iUtil.getPosition(elm),
			jQuery.iUtil.getSize(elm)
		);
		
		elm.dragCfg.oR = {
			x : parseInt(jQuery.css(elm, 'left'))||0,
			y : parseInt(jQuery.css(elm, 'top'))||0
		};
		
		elm.dragCfg.oP = jQuery.css(elm, 'position');
		if (elm.dragCfg.oP != 'relative' && elm.dragCfg.oP != 'absolute') {
			elm.style.position = 'relative';
		}
		
		jQuery.iDrag.getContainment(elm);
		jQuery.iSlider.modifyContainer(elm);		
		
		dx = parseInt(position[0]) || 0;
		dy = parseInt(position[1]) || 0;
		
		nx = elm.dragCfg.oR.x + dx;
		ny = elm.dragCfg.oR.y + dy;
		if(elm.dragCfg.fractions) {
			newCoords = jQuery.iDrag.snapToGrid.apply(elm, [nx, ny, dx, dy]);
			if (newCoords.constructor == Object) {
				dx = newCoords.dx;
				dy = newCoords.dy;
			}
			nx = elm.dragCfg.oR.x + dx;
			ny = elm.dragCfg.oR.y + dy;
		}
		
		newCoords = jQuery.iDrag.fitToContainer.apply(elm, [nx, ny, dx, dy]);
		if (newCoords && newCoords.constructor == Object) {
			dx = newCoords.dx;
			dy = newCoords.dy;
		}
		
		nx = elm.dragCfg.oR.x + dx;
		ny = elm.dragCfg.oR.y + dy;
		
		if (elm.dragCfg.si && (elm.dragCfg.onSlide || elm.dragCfg.onChange)) {
			jQuery.iSlider.onSlide(elm, nx, ny);
		}
		nx = !elm.dragCfg.axis || elm.dragCfg.axis == 'horizontally' ? nx : elm.dragCfg.oR.x||0;
		ny = !elm.dragCfg.axis || elm.dragCfg.axis == 'vertically' ? ny : elm.dragCfg.oR.y||0;
		elm.style.left = nx + 'px';
		elm.style.top = ny + 'px';
	},
	
	build : function(o) {
		return this.each(
			function()
			{
				if (this.isSlider == true || !o.accept || !jQuery.iUtil || !jQuery.iDrag || !jQuery.iDrop){
					return;
				}
				toDrag = jQuery(o.accept, this);
				if (toDrag.size() == 0) {
					return;
				}
				var params = {
					containment: 'parent',
					si : true,
					onSlide : o.onSlide && o.onSlide.constructor == Function ? o.onSlide : null,
					onChange : o.onChange && o.onChange.constructor == Function ? o.onChange : null,
					handle: this,
					opacity: o.opacity||false
				};
				if (o.fractions && parseInt(o.fractions)) {
					params.fractions = parseInt(o.fractions)||1;
					params.fractions = params.fractions > 0 ? params.fractions : 1;
				}
				if (toDrag.size() == 1)
					toDrag.Draggable(params);
				else {
					jQuery(toDrag.get(0)).Draggable(params);
					params.handle = null;
					toDrag.Draggable(params);
				}
				toDrag.keydown(jQuery.iSlider.dragmoveByKey);
				toDrag.attr('tabindex',jQuery.iSlider.tabindex++);	
				
				this.isSlider = true;
				this.slideCfg = {};
				this.slideCfg.onslide = params.onslide;
				this.slideCfg.fractions = params.fractions;
				this.slideCfg.sliders = toDrag;
				this.slideCfg.restricted = o.restricted ? true : false;
				sliderEl = this;
				sliderEl.slideCfg.sliders.each(
					function(nr)
					{
						this.SliderIteration = nr;
						this.SliderContainer = sliderEl;
					}
				);
				if (o.values && o.values.constructor == Array) {
					for (i = o.values.length -1; i>=0;i--) {
						if (o.values[i].constructor == Array && o.values[i].length == 2) {
							el = this.slideCfg.sliders.get(i);
							if (el.tagName) {
								jQuery.iSlider.dragmoveBy(el, o.values[i]);
							}
						}
					}
				}
			}
		);
	}
};
jQuery.fn.extend(
	{
		/**
		 * Create a slider width options
		 * 
		 * @name Slider
		 * @description Create a slider width options
		 * @param Hash hash A hash of parameters. All parameters are optional.
		 * @option Mixed accepts string to select slider indicators or DOMElement slider indicator
		 * @option Integer factions (optional) number of sgments to divide and snap slider
		 * @option Function onSlide (optional) A function to be executed whenever slider indicator it is moved
		 * @option Function onChanged (optional) A function to be executed whenever slider indicator was moved
		 * @option Array values (optional) Initial values for slider indicators
		 * @option Boolean restricted (optional) if true the slider indicator can not be moved beyond adjacent indicators
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		Slider : jQuery.iSlider.build,
		/**
		 * Set value/position for slider indicators
		 * 
		 * @name SliderSetValues
		 * @description Set value/position for slider indicators
		 * @param Array values array width values for each indicator
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SliderSetValues : jQuery.iSlider.set,
		/**
		 * Get value/position for slider indicators
		 * 
		 * @name SliderSetValues
		 * @description Get value/position for slider indicators
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		SliderGetValues : jQuery.iSlider.get
	}
);/**
 * Interface Elements for jQuery
 * Slideshow
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */


/**
 * Creates an image slideshow. The slideshow can autoplay slides, each image can have caption, navigation links: next, prev, each slide. A page may have more then one slideshow, eachone working independently. Each slide can be bookmarked. The source images can be defined by JavaScript in slideshow options or by HTML placing images inside container.
 *
 * 
 * 
 * @name Slideshow
 * @description Creates an image slideshow. The slideshow can autoplay slides, each image can have caption, navigation links: next, prev, each slide. A page may have more then one slideshow, eachone working independently. Each slide can be bookmarked. The source images can be defined by JavaScript in slideshow options or by HTML placing images inside container.
 * @param Hash hash A hash of parameters
 * @option String container container ID
 * @option String loader path to loading indicator image
 * @option String linksPosition (optional) images links position ['top'|'bottom'|null]
 * @option String linksClass (optional) images links cssClass
 * @option String linksSeparator (optional) images links separator
 * @option Integer fadeDuration fade animation duration in miliseconds
 * @option String activeLinkClass (optional) active image link CSS class
 * @option String nextslideClass (optional) next image CSS class
 * @option String prevslideClass (optional) previous image CSS class
 * @option String captionPosition (optional) image caption position ['top'|'bottom'|null]
 * @option String captionClass (optional) image caption CSS class
 * @option String autoplay (optional) seconds to wait untill next images is displayed. This option will make the slideshow to autoplay.
 * @option String random (optional) if slideshow autoplayes the images can be randomized
 * @option Array images (optional) array of hash with keys 'src' (path to image) and 'cation' (image caption) for images
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.islideshow = {
	slideshows: [],
	gonext : function()
	{
		this.blur();
		slideshow = this.parentNode;
		id = jQuery.attr(slideshow, 'id');
		if (jQuery.islideshow.slideshows[id] != null) {
			window.clearInterval(jQuery.islideshow.slideshows[id]);
		}
		slide = slideshow.ss.currentslide + 1;
		if (slideshow.ss.images.length < slide) {
			slide = 1;
		}
		images = jQuery('img', slideshow.ss.holder);
		slideshow.ss.currentslide = slide;
		if (images.size() > 0) {
			images.fadeOut(
				slideshow.ss.fadeDuration,
				jQuery.islideshow.showImage
			);
		}
	},
	goprev : function()
	{
		this.blur();
		slideshow = this.parentNode;
		id = jQuery.attr(slideshow, 'id');
		if (jQuery.islideshow.slideshows[id] != null) {
			window.clearInterval(jQuery.islideshow.slideshows[id]);
		}
		slide = slideshow.ss.currentslide - 1;
		images = jQuery('img', slideshow.ss.holder);
		if (slide < 1) {
			slide = slideshow.ss.images.length ;
		}
		slideshow.ss.currentslide = slide;
		if (images.size() > 0) {
			images.fadeOut(
				slideshow.ss.fadeDuration,
				jQuery.islideshow.showImage
			);
		}
	},
	timer : function (c)
	{
		slideshow = document.getElementById(c);
		if (slideshow.ss.random) {
			slide = slideshow.ss.currentslide;
			while(slide == slideshow.ss.currentslide) {
				slide = 1 + parseInt(Math.random() * slideshow.ss.images.length);
			}
		} else {
			slide = slideshow.ss.currentslide + 1;
			if (slideshow.ss.images.length < slide) {
				slide = 1;
			}
		}
		images = jQuery('img', slideshow.ss.holder);
		slideshow.ss.currentslide = slide;
		if (images.size() > 0) {
			images.fadeOut(
				slideshow.ss.fadeDuration,
				jQuery.islideshow.showImage
			);
		}
	},
	go : function(o)
	{
		var slideshow;
		if (o && o.constructor == Object) {
			if (o.loader) {
				slideshow = document.getElementById(o.loader.slideshow);
				url = window.location.href.split("#");
				o.loader.onload = null;
				if (url.length == 2) {
					slide = parseInt(url[1]);
					show = url[1].replace(slide,'');
					if (jQuery.attr(slideshow,'id') != show) {
						slide = 1;
					}
				} else {
					slide = 1;
				}
			}
			if(o.link) {
				o.link.blur();
				slideshow = o.link.parentNode.parentNode;
				id = jQuery.attr(slideshow, 'id');
				if (jQuery.islideshow.slideshows[id] != null) {
					window.clearInterval(jQuery.islideshow.slideshows[id]);
				}
				url = o.link.href.split("#");
				slide = parseInt(url[1]);
				show = url[1].replace(slide,'');
				if (jQuery.attr(slideshow,'id') != show) {
					slide = 1;
				}
			}
			if (slideshow.ss.images.length < slide || slide < 1) {
				slide = 1;
			}
			slideshow.ss.currentslide = slide;
			slidePos = jQuery.iUtil.getSize(slideshow);
			slidePad = jQuery.iUtil.getPadding(slideshow);
			slideBor = jQuery.iUtil.getBorder(slideshow);
			if (slideshow.ss.prevslide) {
				slideshow.ss.prevslide.o.css('display', 'none');
			}
			if (slideshow.ss.nextslide) {
				slideshow.ss.nextslide.o.css('display', 'none');
			}
			
			//center loader
			if (slideshow.ss.loader) {
				y = parseInt(slidePad.t) + parseInt(slideBor.t);
				if (slideshow.ss.slideslinks) {
					if (slideshow.ss.slideslinks.linksPosition == 'top') {
						y += slideshow.ss.slideslinks.dimm.hb;
					} else {
						slidePos.h -= slideshow.ss.slideslinks.dimm.hb;
					}
				}
				if (slideshow.ss.slideCaption) {
					if (slideshow.ss.slideCaption && slideshow.ss.slideCaption.captionPosition == 'top') {
						y += slideshow.ss.slideCaption.dimm.hb;
					} else {
						slidePos.h -= slideshow.ss.slideCaption.dimm.hb;
					}
				}
				if (!slideshow.ss.loaderWidth) {
					slideshow.ss.loaderHeight = o.loader ? o.loader.height : (parseInt(slideshow.ss.loader.css('height'))||0);
					slideshow.ss.loaderWidth = o.loader ? o.loader.width : (parseInt(slideshow.ss.loader.css('width'))||0);
				}
				
				slideshow.ss.loader.css('top', y + (slidePos.h - slideshow.ss.loaderHeight)/2 + 'px');
				slideshow.ss.loader.css('left', (slidePos.wb - slideshow.ss.loaderWidth)/2 + 'px');
				slideshow.ss.loader.css('display', 'block');
			}
			
			//getimage
			images = jQuery('img', slideshow.ss.holder);
			if (images.size() > 0) {
				images.fadeOut(
					slideshow.ss.fadeDuration,
					jQuery.islideshow.showImage
				);
			} else {
				lnk = jQuery('a', slideshow.ss.slideslinks.o).get(slide-1);
				jQuery(lnk).addClass(slideshow.ss.slideslinks.activeLinkClass);
				var img = new Image();
				img.slideshow = jQuery.attr(slideshow,'id');
				img.slide = slide-1;
				img.src = slideshow.ss.images[slideshow.ss.currentslide-1].src ;
				if (img.complete) {
					img.onload = null;
					jQuery.islideshow.display.apply(img);
				} else {
					img.onload = jQuery.islideshow.display;
				}
				//slideshow.ss.holder.html('<img src="' + slideshow.ss.images[slide-1].src + '" />');
				if (slideshow.ss.slideCaption) {
					slideshow.ss.slideCaption.o.html(slideshow.ss.images[slide-1].caption);
				}
				//jQuery('img', slideshow.ss.holder).bind('load',jQuery.slideshowDisplay);
			}
		}
	},
	showImage : function()
	{
		slideshow = this.parentNode.parentNode;
		slideshow.ss.holder.css('display','none');
		if (slideshow.ss.slideslinks.activeLinkClass) {
			lnk = jQuery('a', slideshow.ss.slideslinks.o).removeClass(slideshow.ss.slideslinks.activeLinkClass).get(slideshow.ss.currentslide - 1);
			jQuery(lnk).addClass(slideshow.ss.slideslinks.activeLinkClass);
		}
		//slideshow.ss.holder.html('<img src="' + slideshow.ss.images[slideshow.ss.currentslide - 1].src + '" />');
		
		var img = new Image();
		img.slideshow = jQuery.attr(slideshow,'id');
		img.slide = slideshow.ss.currentslide - 1;
		img.src = slideshow.ss.images[slideshow.ss.currentslide - 1].src ;
		if (img.complete) {
			img.onload = null;
			jQuery.islideshow.display.apply(img);
		} else {
			img.onload = jQuery.islideshow.display;
		}
		if (slideshow.ss.slideCaption) {
			slideshow.ss.slideCaption.o.html(slideshow.ss.images[slideshow.ss.currentslide-1].caption);
		}
		//jQuery('img', slideshow.ss.holder).bind('load',jQuery.slideshowDisplay);
	},
	display : function ()
	{
		slideshow = document.getElementById(this.slideshow);
		if (slideshow.ss.prevslide) {
			slideshow.ss.prevslide.o.css('display', 'none');
		}
		if (slideshow.ss.nextslide) {
			slideshow.ss.nextslide.o.css('display', 'none');
		}
		slidePos = jQuery.iUtil.getSize(slideshow);
		y = 0;
		if (slideshow.ss.slideslinks) {
			if (slideshow.ss.slideslinks.linksPosition == 'top') {
				y += slideshow.ss.slideslinks.dimm.hb;
			} else {
				slidePos.h -= slideshow.ss.slideslinks.dimm.hb;
			}
		}
		if (slideshow.ss.slideCaption) {
			if (slideshow.ss.slideCaption && slideshow.ss.slideCaption.captionPosition == 'top') {
				y += slideshow.ss.slideCaption.dimm.hb;
			} else {
				slidePos.h -= slideshow.ss.slideCaption.dimm.hb;
			}
		}
		par = jQuery('.slideshowHolder', slideshow);
		y = y + (slidePos.h - this.height)/2 ;
		x = (slidePos.wb - this.width)/2;
		slideshow.ss.holder.css('top', y + 'px').css('left', x + 'px').html('<img src="' + this.src + '" />');
		slideshow.ss.holder.fadeIn(slideshow.ss.fadeDuration);
		nextslide = slideshow.ss.currentslide + 1;
		if (nextslide > slideshow.ss.images.length) {
			nextslide = 1;
		}
		prevslide = slideshow.ss.currentslide - 1;
		if (prevslide < 1) {
			prevslide = slideshow.ss.images.length;
		}
		slideshow.ss.nextslide.o
				.css('display','block')
				.css('top', y + 'px')
				.css('left', x + 2 * this.width/3 + 'px')
				.css('width', this.width/3 + 'px')
				.css('height', this.height + 'px')
				.attr('title', slideshow.ss.images[nextslide-1].caption);
		slideshow.ss.nextslide.o.get(0).href = '#' + nextslide + jQuery.attr(slideshow, 'id');
		slideshow.ss.prevslide.o
				.css('display','block')
				.css('top', y + 'px')
				.css('left', x + 'px')
				.css('width', this.width/3 + 'px')
				.css('height', this.height + 'px')
				.attr('title', slideshow.ss.images[prevslide-1].caption);
		slideshow.ss.prevslide.o.get(0).href = '#' + prevslide + jQuery.attr(slideshow, 'id');
	},
	build : function(o)
	{
		if (!o || !o.container || jQuery.islideshow.slideshows[o.container])
			return;
		var container = jQuery('#' + o.container);
		var el = container.get(0);
		
		if (el.style.position != 'absolute' && el.style.position != 'relative') {
			el.style.position = 'relative';
		}
		el.style.overflow = 'hidden';
		if (container.size() == 0)
			return;
		el.ss = {};
		
		el.ss.images = o.images ? o.images : [];
		el.ss.random = o.random && o.random == true || false;
		imgs = el.getElementsByTagName('IMG');
		for(i = 0; i< imgs.length; i++) {
			indic = el.ss.images.length;
			el.ss.images[indic] = {src:imgs[i].src, caption:imgs[i].title||imgs[i].alt||''};
		}
		
		if (el.ss.images.length == 0) {
			return;
		}
		
		el.ss.oP = jQuery.extend(
				jQuery.iUtil.getPosition(el),
				jQuery.iUtil.getSize(el)
			);
		el.ss.oPad = jQuery.iUtil.getPadding(el);
		el.ss.oBor = jQuery.iUtil.getBorder(el);
		t = parseInt(el.ss.oPad.t) + parseInt(el.ss.oBor.t);
		b = parseInt(el.ss.oPad.b) + parseInt(el.ss.oBor.b);
		jQuery('img', el).remove();
		el.ss.fadeDuration = o.fadeDuration ? o.fadeDuration : 500;
		if (o.linksPosition || o.linksClass || o.activeLinkClass) {
			el.ss.slideslinks = {};
			container.append('<div class="slideshowLinks"></div>');
			el.ss.slideslinks.o = jQuery('.slideshowLinks', el);
			if (o.linksClass) {
				el.ss.slideslinks.linksClass = o.linksClass;
				el.ss.slideslinks.o.addClass(o.linksClass);
			}
			if (o.activeLinkClass) {
				el.ss.slideslinks.activeLinkClass = o.activeLinkClass;
			}
			el.ss.slideslinks.o.css('position','absolute').css('width', el.ss.oP.w + 'px');
			if (o.linksPosition && o.linksPosition == 'top') {
				el.ss.slideslinks.linksPosition = 'top';
				el.ss.slideslinks.o.css('top',t + 'px');
			} else {
				el.ss.slideslinks.linksPosition = 'bottom';
				el.ss.slideslinks.o.css('bottom',b + 'px');
			}
			el.ss.slideslinks.linksSeparator = o.linksSeparator ? o.linksSeparator : ' ';
			for (var i=0; i<el.ss.images.length; i++) {
				indic = parseInt(i) + 1;
				el.ss.slideslinks.o.append('<a href="#' + indic + o.container + '" class="slideshowLink" title="' + el.ss.images[i].caption + '">' + indic + '</a>' + (indic != el.ss.images.length ? el.ss.slideslinks.linksSeparator : ''));
			}
			jQuery('a', el.ss.slideslinks.o).bind(
				'click',
				function()
				{
					jQuery.islideshow.go({link:this})
				}
			);
			el.ss.slideslinks.dimm = jQuery.iUtil.getSize(el.ss.slideslinks.o.get(0));
		}
		if (o.captionPosition || o.captionClass) {
			el.ss.slideCaption = {};
			container.append('<div class="slideshowCaption">&nbsp;</div>');
			el.ss.slideCaption.o = jQuery('.slideshowCaption', el);
			if (o.captionClass) {
				el.ss.slideCaption.captionClass = o.captionClass;
				el.ss.slideCaption.o.addClass(o.captionClass);
			}
			el.ss.slideCaption.o.css('position','absolute').css('width', el.ss.oP.w + 'px');
			if (o.captionPosition&& o.captionPosition == 'top') {
				el.ss.slideCaption.captionPosition = 'top';
				el.ss.slideCaption.o.css('top', (el.ss.slideslinks && el.ss.slideslinks.linksPosition == 'top' ? el.ss.slideslinks.dimm.hb + t : t) + 'px');
			} else {
				el.ss.slideCaption.captionPosition = 'bottom';
				el.ss.slideCaption.o.css('bottom', (el.ss.slideslinks && el.ss.slideslinks.linksPosition == 'bottom' ? el.ss.slideslinks.dimm.hb + b : b) + 'px');
			}
			el.ss.slideCaption.dimm = jQuery.iUtil.getSize(el.ss.slideCaption.o.get(0));
		}
		
		if (o.nextslideClass) {
			el.ss.nextslide = {nextslideClass:o.nextslideClass};
			container.append('<a href="#2' + o.container + '" class="slideshowNextSlide">&nbsp;</a>');
			el.ss.nextslide.o = jQuery('.slideshowNextSlide', el);
			el.ss.nextslide.o.css('position', 'absolute').css('display', 'none').css('overflow','hidden').css('fontSize', '30px').addClass(el.ss.nextslide.nextslideClass);
			el.ss.nextslide.o.bind('click', jQuery.islideshow.gonext);
		}
		if (o.prevslideClass) {
			el.ss.prevslide= {prevslideClass:o.prevslideClass};
			container.append('<a href="#0' + o.container + '" class="slideshowPrevslide">&nbsp;</a>');
			el.ss.prevslide.o = jQuery('.slideshowPrevslide', el);
			el.ss.prevslide.o.css('position', 'absolute').css('display', 'none').css('overflow','hidden').css('fontSize', '30px').addClass(el.ss.prevslide.prevslideClass);
			el.ss.prevslide.o.bind('click', jQuery.islideshow.goprev);
		}
		
		container.prepend('<div class="slideshowHolder"></div>');
		el.ss.holder = jQuery('.slideshowHolder', el);
		el.ss.holder.css('position','absolute').css('top','0px').css('left','0px').css('display', 'none');
		if (o.loader) {
			container.prepend('<div class="slideshowLoader" style="display: none;"><img src="' + o.loader + '" /></div>');
			el.ss.loader = jQuery('.slideshowLoader', el);
			el.ss.loader.css('position', 'absolute');
			var img = new Image();
			img.slideshow = o.container;
			img.src = o.loader;
			if (img.complete) {
				img.onload = null;
				jQuery.islideshow.go({loader:img});
			} else {
				img.onload = function()
				{
					jQuery.islideshow.go({loader:this});
				};
			}
		} else {
			jQuery.islideshow.go({container:el});
		}
		
		if(o.autoplay) {
			time = parseInt(o.autoplay) * 1000;
		}
		jQuery.islideshow.slideshows[o.container] = o.autoplay ? window.setInterval('jQuery.islideshow.timer(\'' + o.container + '\')', time) : null;
	}
};
jQuery.slideshow = jQuery.islideshow.build;/**
 * Interface Elements for jQuery
 * Sortables
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Allows you to resort elements within a container by dragging and dropping. Requires
 * the Draggables and Droppables plugins. The container and each item inside the container
 * must have an ID. Sortables are especially useful for lists.
 * 
 * @see Plugins/Interface/Draggable
 * @see Plugins/Interface/Droppable
 * @author Stefan Petre
 * @name Sortable
 * @cat Plugins/Interface
 * @param Hash options        A hash of options
 * @option String accept      The class name for items inside the container (mandatory)
 * @option String activeclass The class for the container when one of its items has started to move
 * @option String hoverclass  The class for the container when an acceptable item is inside it
 * @option String helperclass The helper is used to point to the place where the item will be 
 *                            moved. This is the class for the helper.
 * @option Float opacity      Opacity (between 0 and 1) of the item while being dragged
 * @option Boolean ghosting   When true, the sortable is ghosted when dragged
 * @option String tolerance   Either 'pointer', 'intersect', or 'fit'. See Droppable for more details
 * @option Boolean fit        When true, sortable must be inside the container in order to drop
 * @option Integer fx         Duration for the effect applied to the sortable
 * @option Function onchange  Callback that gets called when the sortable list changed. It takes
 *                            an array of serialized elements
 * @option Boolean floats     True if the sorted elements are floated
 * @option String containment Use 'parent' to constrain the drag to the container
 * @option String axis        Use 'horizontally' or 'vertically' to constrain dragging to an axis
 * @option String handle      The jQuery selector that indicates the draggable handle
 * @option DOMElement handle  The node that indicates the draggable handle
 * @option Function onHover   Callback that is called when an acceptable item is dragged over the
 *                            container. Gets the hovering DOMElement as a parameter
 * @option Function onOut     Callback that is called when an acceptable item leaves the container.
 *                            Gets the leaving DOMElement as a parameter
 * @option Object cursorAt    The mouse cursor will be moved to the offset on the dragged item
 *                            indicated by the object, which takes "top", "bottom", "left", and
 *                            "right" keys
 * @option Function onStart   Callback function triggered when the dragging starts
 * @option Function onStop    Callback function triggered when the dragging stops
 * @example                   $('ul').Sortable(
 *                            	{
 *                            		accept : 'sortableitem',
 *                            		activeclass : 'sortableactive',
 *                             		hoverclass : 'sortablehover',
 *                             		helperclass : 'sorthelper',
 *                             		opacity: 	0.5,
 *                             		fit :	false
 *                             	}
 *                             )
 */

jQuery.iSort = {
	changed : [],
	collected : {},
	helper : false,
	inFrontOf: null,
	
	start : function ()
	{
		if (jQuery.iDrag.dragged == null) {
			return;
		}
		var shs, margins,c, cs;
		
		jQuery.iSort.helper.get(0).className = jQuery.iDrag.dragged.dragCfg.hpc;
		shs = jQuery.iSort.helper.get(0).style;
		shs.display = 'block';
		jQuery.iSort.helper.oC = jQuery.extend(
			jQuery.iUtil.getPosition(jQuery.iSort.helper.get(0)),
			jQuery.iUtil.getSize(jQuery.iSort.helper.get(0))
		);
		
		shs.width = jQuery.iDrag.dragged.dragCfg.oC.wb + 'px';
		shs.height = jQuery.iDrag.dragged.dragCfg.oC.hb + 'px';
		//shs.cssFloat = jQuery.iDrag.dragged.dragCfg.oF;
		margins = jQuery.iUtil.getMargins(jQuery.iDrag.dragged);
		shs.marginTop = margins.t;
		shs.marginRight = margins.r;
		shs.marginBottom = margins.b;
		shs.marginLeft = margins.l;
		if (jQuery.iDrag.dragged.dragCfg.ghosting == true) {
			c = jQuery.iDrag.dragged.cloneNode(true);
			cs = c.style;
			cs.marginTop = '0px';
			cs.marginRight = '0px';
			cs.marginBottom = '0px';
			cs.marginLeft = '0px';
			cs.display = 'block';
			jQuery.iSort.helper.empty().append(c);
		}
		jQuery(jQuery.iDrag.dragged).after(jQuery.iSort.helper.get(0));
		jQuery.iDrag.dragged.style.display = 'none';
	},
	
	check : function (e)
	{
		if (!e.dragCfg.so && jQuery.iDrop.overzone.sortable) {
			if (e.dragCfg.onStop)
				e.dragCfg.onStop.apply(dragged);
			jQuery(e).css('position', e.dragCfg.initialPosition || e.dragCfg.oP);
			jQuery(e).DraggableDestroy();
			jQuery(jQuery.iDrop.overzone).SortableAddItem(e);
		}
		jQuery.iSort.helper.removeClass(e.dragCfg.hpc).html('&nbsp;');
		jQuery.iSort.inFrontOf = null;
		var shs = jQuery.iSort.helper.get(0).style;
		shs.display = 'none';
		jQuery.iSort.helper.after(e);
		if (e.dragCfg.fx > 0) {
			jQuery(e).fadeIn(e.dragCfg.fx);
		}
		jQuery('body').append(jQuery.iSort.helper.get(0));
		var ts = [];
		var fnc = false;
		for(var i=0; i<jQuery.iSort.changed.length; i++){
			var iEL = jQuery.iDrop.zones[jQuery.iSort.changed[i]].get(0);
			var id = jQuery.attr(iEL, 'id');
			var ser = jQuery.iSort.serialize(id);
			if (iEL.dropCfg.os != ser.hash) {
				iEL.dropCfg.os = ser.hash;
				if (fnc == false && iEL.dropCfg.onChange) {
					fnc = iEL.dropCfg.onChange;
				}
				ser.id = id;
				ts[ts.length] = ser;
			}
		}
		jQuery.iSort.changed = [];
		if (fnc != false && ts.length > 0) {
			fnc(ts);
		}
	},
	
	checkhover : function(e,o)
	{
		if (!jQuery.iDrag.dragged)
			return;
		var cur = false;
		var i = 0;
		if ( e.dropCfg.el.size() > 0) {
			for (i = e.dropCfg.el.size(); i >0; i--) {
				if (e.dropCfg.el.get(i-1) != jQuery.iDrag.dragged) {
					if (!e.sortCfg.floats) {
						if ( 
						(e.dropCfg.el.get(i-1).pos.y + e.dropCfg.el.get(i-1).pos.hb/2) > jQuery.iDrag.dragged.dragCfg.ny  
						) {
							cur = e.dropCfg.el.get(i-1);
						} else {
							break;
						}
					} else {
						if (
						(e.dropCfg.el.get(i-1).pos.x + e.dropCfg.el.get(i-1).pos.wb/2) > jQuery.iDrag.dragged.dragCfg.nx && 
						(e.dropCfg.el.get(i-1).pos.y + e.dropCfg.el.get(i-1).pos.hb/2) > jQuery.iDrag.dragged.dragCfg.ny  
						) {
							cur = e.dropCfg.el.get(i-1);
						}
					}
				}
			}
		}
		//helpos = jQuery.iUtil.getPos(jQuery.iSort.helper.get(0));
		if (cur && jQuery.iSort.inFrontOf != cur) {
			jQuery.iSort.inFrontOf = cur;
			jQuery(cur).before(jQuery.iSort.helper.get(0));
		} else if(!cur && (jQuery.iSort.inFrontOf != null || jQuery.iSort.helper.get(0).parentNode != e) ) {
			jQuery.iSort.inFrontOf = null;
			jQuery(e).append(jQuery.iSort.helper.get(0));
		}
		jQuery.iSort.helper.get(0).style.display = 'block';
	},
	
	measure : function (e)
	{
		if (jQuery.iDrag.dragged == null) {
			return;
		}
		e.dropCfg.el.each (
			function ()
			{
				this.pos = jQuery.extend(
					jQuery.iUtil.getSizeLite(this),
					jQuery.iUtil.getPositionLite(this)
				);
			}
		);
	},
	
	serialize : function(s)
	{
		var i;
		var h = '';
		var o = {};
		if (s) {
			if (jQuery.iSort.collected[s] ) {
				o[s] = [];
				jQuery('#' + s + ' .' + jQuery.iSort.collected[s]).each(
					function ()
					{
						if (h.length > 0) {
							h += '&';
						}
						h += s + '[]=' + jQuery.attr(this,'id');
						o[s][o[s].length] = jQuery.attr(this,'id');
					}
				);
			} else {
				for ( a in s) {
					if (jQuery.iSort.collected[s[a]] ) {
						o[s[a]] = [];			
						jQuery('#' + s[a] + ' .' + jQuery.iSort.collected[s[a]]).each(
							function ()
							{
								if (h.length > 0) {
									h += '&';
								}
								h += s[a] + '[]=' + jQuery.attr(this,'id');
								o[s[a]][o[s[a]].length] = jQuery.attr(this,'id');
							}
						);
					}
				}
			}
		} else {
			for ( i in jQuery.iSort.collected){
				o[i] = [];
				jQuery('#' + i + ' .' + jQuery.iSort.collected[i]).each(
					function ()
					{
						if (h.length > 0) {
							h += '&';
						}
						h += i + '[]=' + jQuery.attr(this,'id');
						o[i][o[i].length] = jQuery.attr(this,'id');
					}
				);
			}
		}
		return {hash:h, o:o};
	},
	
	addItem : function (e)
	{
		if ( !e.childNodes ) {
			return;
		}
		return this.each(
			function ()
			{
				if(!this.sortCfg || !jQuery(e).is('.' +  this.sortCfg.accept))
					jQuery(e).addClass(this.sortCfg.accept);
				jQuery(e).Draggable(this.sortCfg.dragCfg);
			}
		);
	},
	
	destroy: function()
	{
		return this.each(
			function()
			{
				jQuery('.' + this.sortCfg.accept).DraggableDestroy();
				jQuery(this).DroppableDestroy();
				this.sortCfg = null;
				this.isSortable = null;
			}
		);
	},
	
	build : function (o)
	{
		if (o.accept && jQuery.iUtil && jQuery.iDrag && jQuery.iDrop) {
			if (!jQuery.iSort.helper) {
				jQuery('body',document).append('<div id="sortHelper">&nbsp;</div>');
				jQuery.iSort.helper = jQuery('#sortHelper');
				jQuery.iSort.helper.get(0).style.display = 'none';
			}
			this.Droppable(
				{
					accept :  o.accept,
					activeclass : o.activeclass ? o.activeclass : false,
					hoverclass : o.hoverclass ? o.hoverclass : false,
					helperclass : o.helperclass ? o.helperclass : false,
					/*onDrop: function (drag, fx) 
							{
								jQuery.iSort.helper.after(drag);
								if (fx > 0) {
									jQuery(drag).fadeIn(fx);
								}
							},*/
					onHover: o.onHover||o.onhover,
					onOut: o.onOut||o.onout,
					sortable : true,
					onChange : 	o.onChange||o.onchange,
					fx : o.fx ? o.fx : false,
					ghosting : o.ghosting ? true : false,
					tolerance: o.tolerance ? o.tolerance : 'intersect'
				}
			);
			
			return this.each(
				function()
				{
					var dragCfg = {
						revert : o.revert? true : false,
						zindex : 3000,
						opacity : o.opacity ? parseFloat(o.opacity) : false,
						hpc : o.helperclass ? o.helperclass : false,
						fx : o.fx ? o.fx : false,
						so : true,
						ghosting : o.ghosting ? true : false,
						handle: o.handle ? o.handle : null,
						containment: o.containment ? o.containment : null,
						onStart : o.onStart && o.onStart.constructor == Function ? o.onStart : false,
						onDrag : o.onDrag && o.onDrag.constructor == Function ? o.onDrag : false,
						onStop : o.onStop && o.onStop.constructor == Function ? o.onStop : false,
						axis : /vertically|horizontally/.test(o.axis) ? o.axis : false,
						snapDistance : o.snapDistance ? parseInt(o.snapDistance)||0 : false,
						cursorAt: o.cursorAt ? o.cursorAt : false
					};
					jQuery('.' + o.accept, this).Draggable(dragCfg);
					this.isSortable = true;
					this.sortCfg = {
						accept :  o.accept,
						revert : o.revert? true : false,
						zindex : 3000,
						opacity : o.opacity ? parseFloat(o.opacity) : false,
						hpc : o.helperclass ? o.helperclass : false,
						fx : o.fx ? o.fx : false,
						so : true,
						ghosting : o.ghosting ? true : false,
						handle: o.handle ? o.handle : null,
						containment: o.containment ? o.containment : null,
						floats: o.floats ? true : false,
						dragCfg : dragCfg
					}
				}
			);
		}
	}
};

jQuery.fn.extend(
	{
		Sortable : jQuery.iSort.build,
		/**
		 * A new item can be added to a sortable by adding it to the DOM and then adding it via
		 * SortableAddItem. 
		 *
		 * @name SortableAddItem
		 * @param DOMElement elem A DOM Element to add to the sortable list
		 * @example $('#sortable1').append('<li id="newitem">new item</li>')
		 *                         .SortableAddItem($("#new_item")[0])
		 * @type jQuery
		 * @cat Plugins/Interface
		 */
		SortableAddItem : jQuery.iSort.addItem,
		/**
		 * Destroy a sortable
		 *
		 * @name SortableDestroy
		 * @example $('#sortable1').SortableDestroy();
		 * @type jQuery
		 * @cat Plugins/Interface
		 */
		SortableDestroy: jQuery.iSort.destroy
	}
);

/**
 * This function returns the hash and an object (can be used as arguments for $.post) for every 
 * sortable in the page or specific sortables. The hash is based on the 'id' attributes of 
 * container and items.
 *
 * @params String sortable The id of the sortable to serialize
 * @name $.SortSerialize
 * @type String
 * @cat Plugins/Interface
 */

jQuery.SortSerialize = jQuery.iSort.serialize;/**
 * Interface Elements for jQuery
 * Tooltip
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 */

/**
 * Creates tooltips using title attribute
 *
 * 
 * 
 * @name ToolTip
 * @description Creates tooltips using title attribute
 * @param Hash hash A hash of parameters
 * @option String position tooltip's position ['top'|'left'|'right'|'bottom'|'mouse']
 * @options Function onShow (optional) A function to be executed whenever the tooltip is displayed
 * @options Function onHide (optional) A function to be executed whenever the tooltip is hidden
 *
 * @type jQuery
 * @cat Plugins/Interface
 * @author Stefan Petre
 */
jQuery.iTooltip = {
	current : null,
	focused : false,
	oldTitle : null,
	focus : function(e)
	{
		jQuery.iTooltip.focused = true;
		jQuery.iTooltip.show(e, this, true);
	},
	hidefocused : function(e)
	{
		if (jQuery.iTooltip.current != this)
			return ;
		jQuery.iTooltip.focused = false;
		jQuery.iTooltip.hide(e, this);
	},
	show : function(e, el, focused)
	{
		if (jQuery.iTooltip.current != null)
			return ;
		if (!el) {
			el = this;
		}
		
		jQuery.iTooltip.current = el;
		pos = jQuery.extend(
			jQuery.iUtil.getPosition(el),
			jQuery.iUtil.getSize(el)
		);
		jEl = jQuery(el);
		title = jEl.attr('title');
		href = jEl.attr('href');
		if (title) {
			jQuery.iTooltip.oldTitle = title;
			jEl.attr('title','');
			jQuery('#tooltipTitle').html(title);
			if (href)
				jQuery('#tooltipURL').html(href.replace('http://', ''));
			else 
				jQuery('#tooltipURL').html('');
			helper = jQuery('#tooltipHelper');
			if(el.tooltipCFG.className){
				helper.get(0).className = el.tooltipCFG.className;
			} else {
				helper.get(0).className = '';
			}
			helperSize = jQuery.iUtil.getSize(helper.get(0));
			filteredPosition = focused && el.tooltipCFG.position == 'mouse' ? 'bottom' : el.tooltipCFG.position;
			
			switch (filteredPosition) {
				case 'top':
					ny = pos.y - helperSize.hb;
					nx = pos.x;
				break;
				case 'left' :
					ny = pos.y;
					nx = pos.x - helperSize.wb;
				break;
				case 'right' :
					ny = pos.y;
					nx = pos.x + pos.wb;
				break;
				case 'mouse' :
					jQuery('body').bind('mousemove', jQuery.iTooltip.mousemove);
					pointer = jQuery.iUtil.getPointer(e);
					ny = pointer.y + 15;
					nx = pointer.x + 15;
				break;
				default :
					ny = pos.y + pos.hb;
					nx = pos.x;
				break;
			}
			helper.css(
				{
					top 	: ny + 'px',
					left	: nx + 'px'
				}
			);
			if (el.tooltipCFG.delay == false) {
				helper.show();
			} else {
				helper.fadeIn(el.tooltipCFG.delay);
			}
			if (el.tooltipCFG.onShow) 
				el.tooltipCFG.onShow.apply(el);
			jEl.bind('mouseout',jQuery.iTooltip.hide)
			   .bind('blur',jQuery.iTooltip.hidefocused);
		}
	},
	mousemove : function(e)
	{
		if (jQuery.iTooltip.current == null) {
			jQuery('body').unbind('mousemove', jQuery.iTooltip.mousemove);
			return;	
		}
		pointer = jQuery.iUtil.getPointer(e);
		jQuery('#tooltipHelper').css(
			{
				top 	: pointer.y + 15 + 'px',
				left	: pointer.x + 15 + 'px'
			}
		);
	},
	hide : function(e, el)
	{
		if (!el) {
			el = this;
		}
		if (jQuery.iTooltip.focused != true && jQuery.iTooltip.current == el) {
			jQuery.iTooltip.current = null;
			jQuery('#tooltipHelper').fadeOut(1);
			jQuery(el)
				.attr('title',jQuery.iTooltip.oldTitle)
				.unbind('mouseout', jQuery.iTooltip.hide)
				.unbind('blur', jQuery.iTooltip.hidefocused);
			if (el.tooltipCFG.onHide) 
				el.tooltipCFG.onHide.apply(el);
			jQuery.iTooltip.oldTitle = null;
		}
	},
	build : function(options)
	{
		if (!jQuery.iTooltip.helper)
		{
			jQuery('body').append('<div id="tooltipHelper"><div id="tooltipTitle"></div><div id="tooltipURL"></div></div>');
			jQuery('#tooltipHelper').css(
				{
					position:	'absolute',
					zIndex:		3000,
					display: 	'none'
				}
			);
			jQuery.iTooltip.helper = true;
		}
		return this.each(
			function(){
				if(jQuery.attr(this,'title')) {
					this.tooltipCFG = {
						position	: /top|bottom|left|right|mouse/.test(options.position) ? options.position : 'bottom',
						className	: options.className ? options.className : false,
						delay		: options.delay ? options.delay : false,
						onShow		: options.onShow && options.onShow.constructor == Function ? options.onShow : false,
						onHide		: options.onHide && options.onHide.constructor == Function ? options.onHide : false
					};
					var el = jQuery(this);
					el.bind('mouseover',jQuery.iTooltip.show);
					el.bind('focus',jQuery.iTooltip.focus);
				}
			}
		);
	}
};

jQuery.fn.ToolTip = jQuery.iTooltip.build;/**
 * Interface Elements for jQuery
 * TTabs
 * 
 * http://interface.eyecon.ro
 * 
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt) 
 * and GPL (GPL-LICENSE.txt) licenses.
 *   
 *
 *
 */

jQuery.iTTabs =
{
	doTab : function(e)
	{
		pressedKey = e.charCode || e.keyCode || -1;
		if (pressedKey == 9) {
			if (window.event) {
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			} else {
				e.preventDefault();
				e.stopPropagation();
			}
			if (this.createTextRange) {
				document.selection.createRange().text="\t";
				this.onblur = function() { this.focus(); this.onblur = null; };
			} else if (this.setSelectionRange) {
				start = this.selectionStart;
				end = this.selectionEnd;
				this.value = this.value.substring(0, start) + "\t" + this.value.substr(end);
				this.setSelectionRange(start + 1, start + 1);
				this.focus();
			}
			return false;
		}
	},
	destroy : function()
	{
		return this.each(
			function()
			{
				if (this.hasTabsEnabled && this.hasTabsEnabled == true) {
					jQuery(this).unbind('keydown', jQuery.iTTabs.doTab);
					this.hasTabsEnabled = false;
				}
			}
		);
	},
	build : function()
	{
		return this.each(
			function()
			{
				if (this.tagName == 'TEXTAREA' && (!this.hasTabsEnabled || this.hasTabsEnabled == false)) {
					jQuery(this).bind('keydown', jQuery.iTTabs.doTab);
					this.hasTabsEnabled = true;
				}
			}
		);			
	}
};

jQuery.fn.extend (
	{
		/**
		 * Enable tabs in textareas
		 * 
		 * @name EnableTabs
		 * @description Enable tabs in textareas
		 *
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		EnableTabs : jQuery.iTTabs.build,
		/**
		 * Disable tabs in textareas
		 * 
		 * @name DisableTabs
		 * @description Disable tabs in textareas
		 *
		 * @type jQuery
		 * @cat Plugins/Interface
		 * @author Stefan Petre
		 */
		DisableTabs : jQuery.iTTabs.destroy
	}
);/**
 * Interface Elements for jQuery
 * utility function
 *
 * http://interface.eyecon.ro
 *
 * Copyright (c) 2006 Stefan Petre
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 *
 */

jQuery.iUtil = {
	getPosition : function(e)
	{
		var x = 0;
		var y = 0;
		var es = e.style;
		var restoreStyles = false;
		if (jQuery(e).css('display') == 'none') {
			var oldVisibility = es.visibility;
			var oldPosition = es.position;
			restoreStyles = true;
			es.visibility = 'hidden';
			es.display = 'block';
			es.position = 'absolute';
		}
		var el = e;
		while (el){
			x += el.offsetLeft + (el.currentStyle && !jQuery.browser.opera ?parseInt(el.currentStyle.borderLeftWidth)||0:0);
			y += el.offsetTop + (el.currentStyle && !jQuery.browser.opera ?parseInt(el.currentStyle.borderTopWidth)||0:0);
			el = el.offsetParent;
		}
		el = e;
		while (el && el.tagName  && el.tagName.toLowerCase() != 'body')
		{
			x -= el.scrollLeft||0;
			y -= el.scrollTop||0;
			el = el.parentNode;
		}
		if (restoreStyles == true) {
			es.display = 'none';
			es.position = oldPosition;
			es.visibility = oldVisibility;
		}
		return {x:x, y:y};
	},
	getPositionLite : function(el)
	{
		var x = 0, y = 0;
		while(el) {
			x += el.offsetLeft || 0;
			y += el.offsetTop || 0;
			el = el.offsetParent;
		}
		return {x:x, y:y};
	},
	getSize : function(e)
	{
		var w = jQuery.css(e,'width');
		var h = jQuery.css(e,'height');
		var wb = 0;
		var hb = 0;
		var es = e.style;
		if (jQuery(e).css('display') != 'none') {
			wb = e.offsetWidth;
			hb = e.offsetHeight;
		} else {
			var oldVisibility = es.visibility;
			var oldPosition = es.position;
			es.visibility = 'hidden';
			es.display = 'block';
			es.position = 'absolute';
			wb = e.offsetWidth;
			hb = e.offsetHeight;
			es.display = 'none';
			es.position = oldPosition;
			es.visibility = oldVisibility;
		}
		return {w:w, h:h, wb:wb, hb:hb};
	},
	getSizeLite : function(el)
	{
		return {
			wb:el.offsetWidth||0,
			hb:el.offsetHeight||0
		};
	},
	getClient : function(e)
	{
		var h, w, de;
		if (e) {
			w = e.clientWidth;
			h = e.clientHeight;
		} else {
			de = document.documentElement;
			w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
			h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
		}
		return {w:w,h:h};
	},
	getScroll : function (e)
	{
		var t=0, l=0, w=0, h=0, iw=0, ih=0;
		if (e && e.nodeName.toLowerCase() != 'body') {
			t = e.scrollTop;
			l = e.scrollLeft;
			w = e.scrollWidth;
			h = e.scrollHeight;
			iw = 0;
			ih = 0;
		} else  {
			if (document.documentElement) {
				t = document.documentElement.scrollTop;
				l = document.documentElement.scrollLeft;
				w = document.documentElement.scrollWidth;
				h = document.documentElement.scrollHeight;
			} else if (document.body) {
				t = document.body.scrollTop;
				l = document.body.scrollLeft;
				w = document.body.scrollWidth;
				h = document.body.scrollHeight;
			}
			iw = self.innerWidth||document.documentElement.clientWidth||document.body.clientWidth||0;
			ih = self.innerHeight||document.documentElement.clientHeight||document.body.clientHeight||0;
		}
		return { t: t, l: l, w: w, h: h, iw: iw, ih: ih };
	},
	getMargins : function(e, toInteger)
	{
		var el = jQuery(e);
		var t = el.css('marginTop') || '';
		var r = el.css('marginRight') || '';
		var b = el.css('marginBottom') || '';
		var l = el.css('marginLeft') || '';
		if (toInteger)
			return {
				t: parseInt(t)||0,
				r: parseInt(r)||0,
				b: parseInt(b)||0,
				l: parseInt(l)
			};
		else
			return {t: t, r: r,	b: b, l: l};
	},
	getPadding : function(e, toInteger)
	{
		var el = jQuery(e);
		var t = el.css('paddingTop') || '';
		var r = el.css('paddingRight') || '';
		var b = el.css('paddingBottom') || '';
		var l = el.css('paddingLeft') || '';
		if (toInteger)
			return {
				t: parseInt(t)||0,
				r: parseInt(r)||0,
				b: parseInt(b)||0,
				l: parseInt(l)
			};
		else
			return {t: t, r: r,	b: b, l: l};
	},
	getBorder : function(e, toInteger)
	{
		var el = jQuery(e);
		var t = el.css('borderTopWidth') || '';
		var r = el.css('borderRightWidth') || '';
		var b = el.css('borderBottomWidth') || '';
		var l = el.css('borderLeftWidth') || '';
		if (toInteger)
			return {
				t: parseInt(t)||0,
				r: parseInt(r)||0,
				b: parseInt(b)||0,
				l: parseInt(l)||0
			};
		else
			return {t: t, r: r,	b: b, l: l};
	},
	getPointer : function(event)
	{
		var x = event.pageX || (event.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft)) || 0;
		var y = event.pageY || (event.clientY + (document.documentElement.scrollTop || document.body.scrollTop)) || 0;
		return {x:x, y:y};
	},
	traverseDOM : function(nodeEl, func)
	{
		func(nodeEl);
		nodeEl = nodeEl.firstChild;
		while(nodeEl){
			jQuery.iUtil.traverseDOM(nodeEl, func);
			nodeEl = nodeEl.nextSibling;
		}
	},
	purgeEvents : function(nodeEl)
	{
		jQuery.iUtil.traverseDOM(
			nodeEl,
			function(el)
			{
				for(var attr in el){
					if(typeof el[attr] === 'function') {
						el[attr] = null;
					}
				}
			}
		);
	},
	centerEl : function(el, axis)
	{
		var clientScroll = jQuery.iUtil.getScroll();
		var windowSize = jQuery.iUtil.getSize(el);
		if (!axis || axis == 'vertically')
			jQuery(el).css(
				{
					top: clientScroll.t + ((Math.max(clientScroll.h,clientScroll.ih) - clientScroll.t - windowSize.hb)/2) + 'px'
				}
			);
		if (!axis || axis == 'horizontally')
			jQuery(el).css(
				{
					left:	clientScroll.l + ((Math.max(clientScroll.w,clientScroll.iw) - clientScroll.l - windowSize.wb)/2) + 'px'
				}
			);
	},
	fixPNG : function (el, emptyGIF) {
		var images = jQuery('img[@src*="png"]', el||document), png;
		images.each( function() {
			png = this.src;				
			this.src = emptyGIF;
			this.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + png + "')";
		});
	}
};

// Helper function to support older browsers!
[].indexOf || (Array.prototype.indexOf = function(v, n){
	n = (n == null) ? 0 : n;
	var m = this.length;
	for (var i=n; i<m; i++)
		if (this[i] == v)
			return i;
	return -1;
});

// file seperator

// Interface patches

//Autocomplete patch
//Adds support for JSON data retrieval.

jQuery.iAuto = {
	helper : null,
	content : null,
	iframe: null,
	timer : null,
	lastValue: null,
	currentValue: null,
	subject: null,
	selectedItem : null,
	items: null,
	
	empty : function()
	{
		jQuery.iAuto.content.empty();
		if (jQuery.iAuto.iframe) {
			jQuery.iAuto.iframe.hide();
		}
	},

	clear : function()
	{
		jQuery.iAuto.items = null;
		jQuery.iAuto.selectedItem = null;
		jQuery.iAuto.lastValue = jQuery.iAuto.subject.value;
		if(jQuery.iAuto.helper.css('display') == 'block') {
			if (jQuery.iAuto.subject.autoCFG.fx) {
				switch(jQuery.iAuto.subject.autoCFG.fx.type) {
					case 'fade':
						jQuery.iAuto.helper.fadeOut(jQuery.iAuto.subject.autoCFG.fx.duration, jQuery.iAuto.empty);
						break;
					case 'slide':
						jQuery.iAuto.helper.SlideOutUp(jQuery.iAuto.subject.autoCFG.fx.duration, jQuery.iAuto.empty);
						break;
					case 'blind':
						jQuery.iAuto.helper.BlindUp(jQuery.iAuto.subject.autoCFG.fx.duration, jQuery.iAuto.empty);
						break;
				}
			} else {
				jQuery.iAuto.helper.hide();
			}
			if (jQuery.iAuto.subject.autoCFG.onHide)
				jQuery.iAuto.subject.autoCFG.onHide.apply(jQuery.iAuto.subject, [jQuery.iAuto.helper, jQuery.iAuto.iframe]);
		} else {
			jQuery.iAuto.empty();
		}
		window.clearTimeout(jQuery.iAuto.timer);
	},

	update : function ()
	{
		var subject = jQuery.iAuto.subject;
		var subjectValue = jQuery.iAuto.getFieldValues(subject);

		var dataSource = subject.autoCFG.source;
		var dataSourceType = subject.autoCFG.dataSourceType;
		var isXML = subject.autoCFG.isXML;
		
		if (subject && subjectValue.item != jQuery.iAuto.lastValue && subjectValue.item.length >= subject.autoCFG.minchars) {
			jQuery.iAuto.lastValue = subjectValue.item;
			jQuery.iAuto.currentValue = subjectValue.item;

			data = {
				field: jQuery(subject).attr('name')||'field',
				value: subjectValue.item
			};
			if (typeof dataSource == 'string') {
				jQuery.ajax(
					{
						type: 'POST',
						data: jQuery.param(data),
						dataType: (isXML) ? 'xml' : 'json',
						success: function(response) {
							jQuery.iAuto.handleData(response, subject, subjectValue, isXML);	
						},
						url : dataSource
					}
				);
			} else if(typeof dataSource == 'function') {
				var returnedData = dataSource(data);
				jQuery.iAuto.handleData(returnedData, subject, subjectValue, isXML);
			}
		}
	},
	
	writeItems : function(subject, toWrite)
	{
		jQuery.iAuto.content.html(toWrite);
		jQuery.iAuto.items = jQuery('li', jQuery.iAuto.content.get(0));
		jQuery.iAuto.items
			.mouseover(jQuery.iAuto.hoverItem)
			.bind('click', jQuery.iAuto.clickItem);
		var position = jQuery.iUtil.getPosition(subject);
		var size = jQuery.iUtil.getSize(subject);
		jQuery.iAuto.helper
			.css('top', position.y + size.hb + 'px')
			.css('left', position.x +  'px')
			.addClass(subject.autoCFG.helperClass);
		if (jQuery.iAuto.iframe) {
			jQuery.iAuto.iframe
				.css('display', 'block')
				.css('top', position.y + size.hb + 'px')
				.css('left', position.x +  'px')
				.css('width', jQuery.iAuto.helper.css('width'))
				.css('height', jQuery.iAuto.helper.css('height'));
		}
		jQuery.iAuto.selectedItem = 0;
		jQuery.iAuto.items.get(0).className = subject.autoCFG.selectClass;
		jQuery.iAuto.applyOn(subject,subject.autoCFG.lastSuggestion[0], 'onHighlight');
		
		if (jQuery.iAuto.helper.css('display') == 'none') {
			if (subject.autoCFG.inputWidth) {
				var borders = jQuery.iUtil.getPadding(subject, true);
				var paddings = jQuery.iUtil.getBorder(subject, true);
				jQuery.iAuto.helper.css('width', subject.offsetWidth - (jQuery.boxModel ? (borders.l + borders.r + paddings.l + paddings.r) : 0 ) + 'px');
			}
			if (subject.autoCFG.fx) {
				switch(subject.autoCFG.fx.type) {
					case 'fade':
						jQuery.iAuto.helper.fadeIn(subject.autoCFG.fx.duration);
						break;
					case 'slide':
						jQuery.iAuto.helper.SlideInUp(subject.autoCFG.fx.duration);
						break;
					case 'blind':
						jQuery.iAuto.helper.BlindDown(subject.autoCFG.fx.duration);
						break;
				}
			} else {
				jQuery.iAuto.helper.show();
			}
			
			if (jQuery.iAuto.subject.autoCFG.onShow)
				jQuery.iAuto.subject.autoCFG.onShow.apply(jQuery.iAuto.subject, [jQuery.iAuto.helper, jQuery.iAuto.iframe]);
		}
	},
	
	checkCache : function()
	{
		var subject = this;
		if (subject.autoCFG.lastSuggestion) {
			
			jQuery.iAuto.lastValue = subject.value;
			jQuery.iAuto.currentValue = subject.value;
			
			var isXML = subject.autoCFG.isXML;
			
			var iterator = function(nr)
				{
					var value, text, testValue;
					if (isXML) {
						value = jQuery('value', this).text();
						text = jQuery('text', this).text();
					} else {
						value = this.value;
						text = this.text;	
					}
					testValue = value.toLowerCase();
					inputValue = subject.value.toLowerCase();
					
					if (testValue.indexOf(inputValue) == 0) {
						toWrite += '<li rel="' + value + '" dir="' + nr + '" style="cursor: default;">' + text + '</li>';
					}
				};
			
			var toWrite = '';
			
			if (isXML) {
				subject.autoCFG.lastSuggestion.each(iterator);
			} else {
				jQuery.each(subject.autoCFG.lastSuggestion, iterator);
			}
			
			if (toWrite != '') {
				jQuery.iAuto.writeItems(subject, toWrite);
				
				this.autoCFG.inCache = true;
				return;
			}
		}
		subject.autoCFG.lastSuggestion = null;
		this.autoCFG.inCache = false;
	},

	selection : function(field, start, end)
	{
		if (field.createTextRange) {
			var selRange = field.createTextRange();
			selRange.collapse(true);
			selRange.moveStart("character", start);
			selRange.moveEnd("character", - end + start);
			selRange.select();
		} else if (field.setSelectionRange) {
			field.setSelectionRange(start, end);
		} else {
			if (field.selectionStart) {
				field.selectionStart = start;
				field.selectionEnd = end;
			}
		}
		field.focus();
	},
	
	getSelectionStart : function(field)
	{
		if (field.selectionStart)
			return field.selectionStart;
		else if(field.createTextRange) {
			var selRange = document.selection.createRange();
			var selRange2 = selRange.duplicate();
			return 0 - selRange2.moveStart('character', -100000);
			//result.end = result.start + range.text.length;
			/*var selRange = document.selection.createRange();
			var isCollapsed = selRange.compareEndPoints("StartToEnd", selRange) == 0;
			if (!isCollapsed)
				selRange.collapse(true);
			var bookmark = selRange.getBookmark();
			return bookmark.charCodeAt(2) - 2;*/
		}
	},
	
	getFieldValues : function(field)
	{
		var fieldData = {
			value: field.value,
			pre: '',
			post: '',
			item: ''
		};
		
		if(field.autoCFG.multiple) {
			var finishedPre = false;
			var selectionStart = jQuery.iAuto.getSelectionStart(field)||0;
			var chunks = fieldData.value.split(field.autoCFG.multipleSeparator);
			for (var i=0; i<chunks.length; i++) {
				if(
					(fieldData.pre.length + chunks[i].length >= selectionStart
					 || 
					selectionStart == 0)
					 && 
					!finishedPre 
				) {
					if (fieldData.pre.length <= selectionStart)
						fieldData.item = chunks[i];
					else 
						fieldData.post += chunks[i] + (chunks[i] != '' ? field.autoCFG.multipleSeparator : '');
					finishedPre = true;
				} else if (finishedPre){
					fieldData.post += chunks[i] + (chunks[i] != '' ? field.autoCFG.multipleSeparator : '');
				}
				if(!finishedPre) {
					fieldData.pre += chunks[i] + (chunks.length > 1 ? field.autoCFG.multipleSeparator : '');
				}
			}
		} else {
			fieldData.item = fieldData.value;
		}
		return fieldData;
	},
	
	autocomplete : function(e)
	{
		window.clearTimeout(jQuery.iAuto.timer);
		var subject = jQuery.iAuto.getFieldValues(this);
				
		var pressedKey = e.charCode || e.keyCode || -1;
		if (/13|27|35|36|38|40|9/.test(pressedKey) && jQuery.iAuto.items) {
			if (window.event) {
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			} else {
				e.preventDefault();
				e.stopPropagation();
			}
			if (jQuery.iAuto.selectedItem != null) 
				jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = '';
			else
				jQuery.iAuto.selectedItem = -1;
			switch(pressedKey) {
				//enter
				case 9:
				case 13:
					if (jQuery.iAuto.selectedItem == -1)
						jQuery.iAuto.selectedItem = 0;
					var selectedItem = jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0);
					var valueToAdd = selectedItem.getAttribute('rel');
					this.value = subject.pre + valueToAdd + this.autoCFG.multipleSeparator + subject.post;
					jQuery.iAuto.lastValue = subject.item;
					jQuery.iAuto.selection(
						this, 
						subject.pre.length + valueToAdd.length + this.autoCFG.multipleSeparator.length, 
						subject.pre.length + valueToAdd.length + this.autoCFG.multipleSeparator.length
					);
					jQuery.iAuto.clear();
					if (this.autoCFG.onSelect) {
						iteration = parseInt(selectedItem.getAttribute('dir'))||0;
						jQuery.iAuto.applyOn(this,this.autoCFG.lastSuggestion[iteration], 'onSelect');
					}
					if (this.scrollIntoView)
						this.scrollIntoView(false);
					return pressedKey != 13;
					break;
				//escape
				case 27:
					this.value = subject.pre + jQuery.iAuto.lastValue + this.autoCFG.multipleSeparator + subject.post;
					this.autoCFG.lastSuggestion = null;
					jQuery.iAuto.clear();
					if (this.scrollIntoView)
						this.scrollIntoView(false);
					return false;
					break;
				//end
				case 35:
					jQuery.iAuto.selectedItem = jQuery.iAuto.items.size() - 1;
					break;
				//home
				case 36:
					jQuery.iAuto.selectedItem = 0;
					break;
				//up
				case 38:
					jQuery.iAuto.selectedItem --;
					if (jQuery.iAuto.selectedItem < 0)
						jQuery.iAuto.selectedItem = jQuery.iAuto.items.size() - 1;
					break;
				case 40:
					jQuery.iAuto.selectedItem ++;
					if (jQuery.iAuto.selectedItem == jQuery.iAuto.items.size())
						jQuery.iAuto.selectedItem = 0;
					break;
			}
			jQuery.iAuto.applyOn(this,this.autoCFG.lastSuggestion[jQuery.iAuto.selectedItem||0], 'onHighlight');
			jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = this.autoCFG.selectClass;
			if (jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).scrollIntoView)
				jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).scrollIntoView(false);
			if(this.autoCFG.autofill) {
				var valToAdd = jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).getAttribute('rel');
				this.value = subject.pre + valToAdd + this.autoCFG.multipleSeparator + subject.post;
				if(jQuery.iAuto.lastValue.length != valToAdd.length)
					jQuery.iAuto.selection(
						this, 
						subject.pre.length + jQuery.iAuto.lastValue.length, 
						subject.pre.length + valToAdd.length
					);
			}
			return false;
		}
		jQuery.iAuto.checkCache.apply(this);
		
		if (this.autoCFG.inCache == false) {
			if (subject.item != jQuery.iAuto.lastValue && subject.item.length >= this.autoCFG.minchars)
				jQuery.iAuto.timer = window.setTimeout(jQuery.iAuto.update, this.autoCFG.delay);
			if (jQuery.iAuto.items) {
				jQuery.iAuto.clear();
			}
		}
		return true;
	},

	applyOn: function(field, item, type)
	{	
		var dataSource = field.autoCFG.source;
		
		if (field.autoCFG[type]) {
			var data = {};
			if (field.autoCFG.isXML) {
				childs = item.getElementsByTagName('*');
				for(i=0; i<childs.length; i++){
					data[childs[i].tagName] = childs[i].firstChild.nodeValue;
				}
			} else {
				data = item;
			}
			field.autoCFG[type].apply(field, [data]);
		}
	},
	
	hoverItem : function(e)
	{
		if (jQuery.iAuto.items) {
			if (jQuery.iAuto.selectedItem != null) 
				jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = '';
			jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = '';
			jQuery.iAuto.selectedItem = parseInt(this.getAttribute('dir'))||0;
			jQuery.iAuto.items.get(jQuery.iAuto.selectedItem||0).className = jQuery.iAuto.subject.autoCFG.selectClass;
		}
	},

	clickItem : function(event)
	{	
		window.clearTimeout(jQuery.iAuto.timer);
		
		event = event || jQuery.event.fix( window.event );
		event.preventDefault();
		event.stopPropagation();
		var subject = jQuery.iAuto.getFieldValues(jQuery.iAuto.subject);
		var valueToAdd = this.getAttribute('rel');
		jQuery.iAuto.subject.value = subject.pre + valueToAdd + jQuery.iAuto.subject.autoCFG.multipleSeparator + subject.post;
		jQuery.iAuto.lastValue = this.getAttribute('rel');
		jQuery.iAuto.selection(
			jQuery.iAuto.subject, 
			subject.pre.length + valueToAdd.length + jQuery.iAuto.subject.autoCFG.multipleSeparator.length, 
			subject.pre.length + valueToAdd.length + jQuery.iAuto.subject.autoCFG.multipleSeparator.length
		);
		jQuery.iAuto.clear();
		if (jQuery.iAuto.subject.autoCFG.onSelect) {
			iteration = parseInt(this.getAttribute('dir'))||0;
			jQuery.iAuto.applyOn(jQuery.iAuto.subject,jQuery.iAuto.subject.autoCFG.lastSuggestion[iteration], 'onSelect');
		}

		return false;
	},

	protect : function(e)
	{
		pressedKey = e.charCode || e.keyCode || -1;
		if (/13|27|35|36|38|40/.test(pressedKey) && jQuery.iAuto.items) {
			if (window.event) {
				window.event.cancelBubble = true;
				window.event.returnValue = false;
			} else {
				e.preventDefault();
				e.stopPropagation();
			}
			return false;
		}
	},

	build : function(options)
	{
		if (!options.source || !jQuery.iUtil) {
			return;
		}

		if (!jQuery.iAuto.helper) {
			if (jQuery.browser.msie) {
				jQuery('body', document).append('<iframe style="display:none;position:absolute;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);" id="autocompleteIframe" src="javascript:false;" frameborder="0" scrolling="no"></iframe>');
				jQuery.iAuto.iframe = jQuery('#autocompleteIframe');
			}
			jQuery('body', document).append('<div id="autocompleteHelper" style="position: absolute; top: 0; left: 0; z-index: 30001; display: none;"><ul style="margin: 0;padding: 0; list-style: none; z-index: 30002;">&nbsp;</ul></div>');
			jQuery.iAuto.helper = jQuery('#autocompleteHelper');
			jQuery.iAuto.content = jQuery('ul', jQuery.iAuto.helper);
		}

		return this.each(
			function()
			{
				if (this.tagName != 'INPUT' && this.getAttribute('type') != 'text' )
					return;
				this.autoCFG = {};
				this.autoCFG.source = options.source;
				this.autoCFG.minchars = Math.abs(parseInt(options.minchars)||1);
				this.autoCFG.helperClass = options.helperClass ? options.helperClass : '';
				this.autoCFG.selectClass = options.selectClass ? options.selectClass : '';
				this.autoCFG.onSelect = options.onSelect && options.onSelect.constructor == Function ? options.onSelect : null;
				this.autoCFG.onShow = options.onShow && options.onShow.constructor == Function ? options.onShow : null;
				this.autoCFG.onHide = options.onHide && options.onHide.constructor == Function ? options.onHide : null;
				this.autoCFG.onHighlight = options.onHighlight && options.onHighlight.constructor == Function ? options.onHighlight : null;
				this.autoCFG.inputWidth = options.inputWidth||false;
				this.autoCFG.dataSourceType = options.dataSourceType || 'xml';
				this.autoCFG.dataSourceType = this.autoCFG.dataSourceType.toLowerCase();
				this.autoCFG.isXML = (this.autoCFG.dataSourceType == 'xml');
				this.autoCFG.multiple = options.multiple||false;
				this.autoCFG.multipleSeparator = this.autoCFG.multiple ? (options.multipleSeparator||', '):'';
				this.autoCFG.autofill = options.autofill ? true : false;
				this.autoCFG.delay = Math.abs(parseInt(options.delay)||1000);
				if (options.fx && options.fx.constructor == Object) {
					if (!options.fx.type || !/fade|slide|blind/.test(options.fx.type)) {
						options.fx.type = 'slide';
					}
					if (options.fx.type == 'slide' && !jQuery.fx.slide)
						return;
					if (options.fx.type == 'blind' && !jQuery.fx.BlindDirection)
						return;

					options.fx.duration = Math.abs(parseInt(options.fx.duration)||400);
					if (options.fx.duration > this.autoCFG.delay) {
						options.fx.duration = this.autoCFG.delay - 100;
					}
					this.autoCFG.fx = options.fx;
				}
				this.autoCFG.lastSuggestion = null;
				this.autoCFG.inCache = false;

				jQuery(this)
					.attr('autocomplete', 'off')
					.focus(
						function()
						{
							jQuery.iAuto.subject = this;
							jQuery.iAuto.lastValue = this.value;
						}
					)
					.keypress(jQuery.iAuto.protect)
					.keyup(jQuery.iAuto.autocomplete)
					
					.blur(
						function()
						{
							jQuery.iAuto.timer = window.setTimeout(jQuery.iAuto.clear, 200);
						}
					);
			}
		);
	}
};

jQuery.iAuto.handleData = function(response, subject, subjectValue, isXML) {
	
	if (response.length == 0) {
		return;
	}
	
	if (isXML) {
		subject.autoCFG.lastSuggestion = jQuery('item',response);
	} else {
		subject.autoCFG.lastSuggestion = response;
	}
	size = subject.autoCFG.lastSuggestion.length;
	if (size > 0) {
		var toWrite = '';
		
		var iterator = function(nr)
			{
				var text, value;
				if (isXML) {
					text = jQuery('text', this).text();
					value = jQuery('value', this).text();
				} else {
					text = this.text;
					value = this.value;
				}
				toWrite += '<li rel="' + value + '" dir="' + nr + '" style="cursor: default;">' + text + '</li>';
		};
		
		if (isXML) {
			subject.autoCFG.lastSuggestion.each(iterator);
		} else {
			jQuery.each(response, iterator);
		}

		if (subject.autoCFG.autofill) {
			var valueToAdd;
			
			if (isXML) {
				valueToAdd = jQuery('value', subject.autoCFG.lastSuggestion[0]).text();
			} else {
				valueToAdd = subject.autoCFG.lastSuggestion[0].value;
			}
			subject.value = subjectValue.pre + valueToAdd + subject.autoCFG.multipleSeparator + subjectValue.post;
			jQuery.iAuto.selection(
				subject, 
				subjectValue.item.length != valueToAdd.length ? (subjectValue.pre.length + subjectValue.item.length) : valueToAdd.length,
				subjectValue.item.length != valueToAdd.length ? (subjectValue.pre.length + valueToAdd.length) : valueToAdd.length
			);
		}

		if (size > 0) {
			jQuery.iAuto.writeItems(subject, toWrite);
		} else {
			jQuery.iAuto.clear();
		}
	} else {
		jQuery.iAuto.clear();
	}
};

jQuery.fn.Autocomplete = jQuery.iAuto.build;

/* ---------- Patches related to the jQuery 1.1.3 bug in 'find' method ---------- */

jQuery.iDrag.build = function(o)
	{
		if (!jQuery.iDrag.helper) {
			jQuery('body',document).append('<div id="dragHelper"></div>');
			jQuery.iDrag.helper = jQuery('#dragHelper');
			var el = jQuery.iDrag.helper.get(0);
			var els = el.style;
			els.position = 'absolute';
			els.display = 'none';
			els.cursor = 'move';
			els.listStyle = 'none';
			els.overflow = 'hidden';
			if (window.ActiveXObject) {
				el.unselectable = "on";
			} else {
				els.mozUserSelect = 'none';
				els.userSelect = 'none';
				els.KhtmlUserSelect = 'none';
			}
		}
		if (!o) {
			o = {};
		}
		
		return this.each(
			function()
			{
				if (this.isDraggable || !jQuery.iUtil)
					return;
				if (window.ActiveXObject) {
					this.onselectstart = function(){return false;};
					this.ondragstart = function(){return false;};
				}
				var el = this;
				var dhe = o.handle ? jQuery(o.handle, this) : jQuery(this);
				if(jQuery.browser.msie) {
					dhe.each(
						function()
						{
							this.unselectable = "on";
						}
					);
				} else {
					dhe.css('-moz-user-select', 'none');
					dhe.css('user-select', 'none');
					dhe.css('-khtml-user-select', 'none');
				}
				this.dragCfg = {
					dhe: dhe,
					revert : o.revert ? true : false,
					ghosting : o.ghosting ? true : false,
					so : o.so ? o.so : false,
					si : o.si ? o.si : false,
					insideParent : o.insideParent ? o.insideParent : false,
					zIndex : o.zIndex ? parseInt(o.zIndex)||0 : false,
					opacity : o.opacity ? parseFloat(o.opacity) : false,
					fx : parseInt(o.fx)||null,
					hpc : o.hpc ? o.hpc : false,
					onDragModifier : {},
					pointer : {},
					onStart : o.onStart && o.onStart.constructor == Function ? o.onStart : false,
					onStop : o.onStop && o.onStop.constructor == Function ? o.onStop : false,
					onChange : o.onChange && o.onChange.constructor == Function ? o.onChange : false,
					axis : /vertically|horizontally/.test(o.axis) ? o.axis : false,
					snapDistance : o.snapDistance ? parseInt(o.snapDistance)||0 : 0,
					cursorAt: o.cursorAt ? o.cursorAt : false,
					autoSize : o.autoSize ? true : false,
					frameClass : o.frameClass || false
					
				};
				if (o.onDragModifier && o.onDragModifier.constructor == Function)
					this.dragCfg.onDragModifier.user = o.onDragModifier;
				if (o.onDrag && o.onDrag.constructor == Function)
					this.dragCfg.onDrag = o.onDrag;
				if (o.containment && ((o.containment.constructor == String && (o.containment == 'parent' || o.containment == 'document')) || (o.containment.constructor == Array && o.containment.length == 4) )) {
					this.dragCfg.containment = o.containment;
				}
				if(o.fractions) {
					this.dragCfg.fractions = o.fractions;
				}
				if(o.grid){
					if(typeof o.grid == 'number'){
						this.dragCfg.gx = parseInt(o.grid)||1;
						this.dragCfg.gy = parseInt(o.grid)||1;
					} else if (o.grid.length == 2) {
						this.dragCfg.gx = parseInt(o.grid[0])||1;
						this.dragCfg.gy = parseInt(o.grid[1])||1;
					}
				}
				if (o.onSlide && o.onSlide.constructor == Function) {
					this.dragCfg.onSlide = o.onSlide;
				}

				this.isDraggable = true;
				dhe.each(
					function(){
						this.dragElem = el;
					}
				);
				dhe.bind('mousedown', jQuery.iDrag.draginit);
			}
		)
	};
jQuery.fn.Draggable = jQuery.iDrag.build;
// file seperator

/**
 * jQBrowser² v1.0.1 - Extend jQuery's browser detection capabilities and implement CSS browser selectors
 *   * http://www.alterform.com/resources/jqbrowser-2
 *
 * Built on the shoulders of (and stolen from :) ) giants:
 *   * John Resig <http://jquery.com/>
 *   * Peter-Paul Koch <http://www.quirksmode.org/?/js/detect.html>
 *	 * Dave Cardwell <http://davecardwell.co.uk/>
 *	 * Rafael Lima <http://rafael.adm.br/css_browser_selector/>
 *
 * Copyright (c) 2006 Nate Cavanaugh, dual licensed under the MIT and GPL
 * licenses:
 *   * http://www.opensource.org/licenses/mit-license.php
 *   * http://www.gnu.org/licenses/gpl.txt
 */

var jQBrowser2 = function() {
	var add_selectors = true;
    /**
     * The following functions and attributes form the internal methods and
     * state of the jQBrowser² plugin.  See the relevant function definition
     * later in the source for further information.
     *
     * Private.browser
     * Private.version
     * Private.OS
     *
     * Private.aol
     * Private.camino
     * Private.firefox
     * Private.flock
     * Private.icab
     * Private.konqueror
     * Private.mozilla
     * Private.msie
     * Private.netscape
     * Private.opera
     * Private.safari
     *
     * Private.linux
     * Private.mac
     * Private.win
     */
    var Private = {
        // Initially set to 'Unknown', if detected each of these properties will
        // be updated.
          'browser': 'Unknown',
          'version': {
              'number': undefined,
              'string': 'Unknown'
          },
               'OS': 'Unknown',

        // Initially set to false, if detected one of the following browsers
        // will be updated.
              'aol': false,
           'camino': false,
          'firefox': false,
            'flock': false,
             'icab': false,
        'konqueror': false,
          'mozilla': false,
             'msie': false,
         'netscape': false,
            'opera': false,
           'safari': false,

        // Initially set to false, if detected one of the following operating
        // systems will be updated.
            'linux': false,
              'mac': false,
              'win': false
    };
	

    /**
     * Loop over the items in 'data' trying to find a browser match with the
     * test in data[i].browser().  Once found, attempt to determine the
     * browser version.
     *
     *       'name': A string containing the full name of the browser.
     * 'identifier': By default this is a lowercase version of 'name', but
     *               this can be overwritten by explicitly defining an
     *               'identifier'.
     *    'browser': A function that returns a boolean value indicating
     *               whether or not the given browser is detected.
     *    'version': An optional function that overwrites the default version
     *               testing.  Must return the result of a .match().
     *
     * Please note that the order of the data array is important, as some
     * browsers contain details of others in their navigator.userAgent string.
     * For example, Flock's contains 'Firefox' so much come before Firefox's
     * test to avoid false positives.
     */
    for( var  i = 0,                    // counter
             ua = navigator.userAgent,  // the navigator's user agent string
             ve = navigator.vendor,     // the navigator's vendor string
           data = [                     // browser tests and data
                { // Safari <http://www.apple.com/safari/>
                          'name': 'Safari',
                       'browser':  /Apple/.test(ve)
                },
                { // Opera <http://www.opera.com/>
                          'name': 'Opera',
                       'browser': window.opera != undefined
                },
                { // iCab <http://www.icab.de/>
                          'name': 'iCab',
                       'browser': /iCab/.test(ve)
                },
                { // Konqueror <http://www.konqueror.org/>
                          'name': 'Konqueror',
                       'browser': /KDE/.test(ve)
                },
                { // AOL Explorer <http://downloads.channel.aol.com/browser>
                    'identifier': 'aol',
                          'name': 'AOL Explorer',
                       'browser': /America Online Browser/.test(ua),
                       'version': ua.match(/rev(\d+(?:\.\d+)+)/)
                },
                { // Flock <http://www.flock.com/>
                          'name': 'Flock',
                       'browser': /Flock/.test(ua)
                },
                { // Camino <http://www.caminobrowser.org/>
                          'name': 'Camino',
                       'browser': /Camino/.test(ve)
                },
                { // Firefox <http://www.mozilla.com/firefox/>
                          'name': 'Firefox',
                       'browser': /Firefox/.test(ua)
                },
                { // Netscape <http://browser.netscape.com/>
                          'name': 'Netscape',
                       'browser': /Netscape/.test(ua)
                },
                { // Internet Explorer <http://www.microsoft.com/windows/ie/>
                  //                   <http://www.microsoft.com/mac/ie/>
                    'identifier': 'msie',
                          'name': 'Internet Explorer',
                       'browser': /MSIE/.test(ua),
                       'version': ua.match(
                                          /MSIE (\d+(?:\.\d+)+(?:b\d*)?)/
                                      )
                },
                { // Mozilla <http://www.mozilla.org/products/mozilla1.x/>
                          'name': 'Mozilla',
                       'browser': /Gecko|Mozilla/.test(ua),
                       'version': ua.match(/rv:(\d+(?:\.\d+)+)/)
                 }
             ];
         i < data.length;
         i++
    ) {
        if( data[i].browser ) { // we have a match
            // If the identifier is not explicitly set, use a lowercase
            // version of the given name.
            var identifier = data[i].identifier ? data[i].identifier
                                                : data[i].name.toLowerCase();

            // Make a note that this browser was detected.
            Private[ identifier ] = true;

            // $.browser.browser() will now return the correct browser.
            Private.browser = data[i].name;

            var result;
            if( data[i].version != undefined && (result = data[i].version) ) {
                // Use the explicitly set test for browser version.
                Private.version.string = result[1];
                Private.version.number = parseFloat( result[1] );
            } else {
                // Otherwise use the default test which searches for the
                // version number after the browser name in the user agent
                // string.
                var re = new RegExp(
                    data[i].name + '(?:\\s|\\/)(\\d+(?:\\.\\d+)+(?:(?:a|b)\\d*)?)'
                );

                result = ua.match(re);
                if( result != undefined ) {
                    Private.version.string = result[1];
                    Private.version.number = parseFloat( result[1] );
                }
            }

            // Once we've detected the browser there is no need to check the
            // others.
            break;
        }
		
    };



    /**
     * Loop over the items in 'data' trying to find a operating system match
     * with the test in data[i].os().
     *
     *       'name': A string containing the full name of the operating
     *               system.
     * 'identifier': By default this is a lowercase version of 'name', but
     *               this can be overwritten by explicitly defining an
     *               'identifier'.
     *         'OS': A function that returns a boolean value indicating
     *               whether or not the given operating system is detected.
     */
    for( var  i = 0,                  // counter
             pl = navigator.platform, // the navigator's platform string
           data = [                   // OS data and tests
                { // Microsoft Windows <http://www.microsoft.com/windows/>
                    'identifier': 'win',
                          'name': 'Windows',
                            'OS': /Win/.test(pl)
                },
                { // Apple Mac OS <http://www.apple.com/macos/>
                          'name': 'Mac',
                            'OS': /Mac/.test(pl)
                },
                { // Linux <http://www.linux.org/>
                          'name': 'Linux',
                            'OS': /Linux/.test(pl)
                }
           ];
       i < data.length;
       i++
    ) {
        if( data[i].OS ) { // we have a match
            // If the identifier is not explicitly set, use a lowercase
            // version of the given name.
            var identifier = data[i].identifier ? data[i].identifier
                                                : data[i].name.toLowerCase();

            // Make a note that the OS was detected.
            Private[ identifier ] = true;

            // $.browser.OS() will now return the correct OS.
            Private.OS = data[i].name;

            // Once we've detected the browser there is no need to check the
            // others.
            break;
        }
    };
	/**
     * The following functions and attributes form the Public interface of the
     * jQBrowser² plugin, accessed externally through the $.browser object.
     * See the relevant function definition later in the source for further
     * information.
     *
     * $.browser.browser
     * $.browser.version.number()
     * $.browser.version.string()
	 * * * version.string() and version.number both take arguments ( best to use 'round'), to round out the version number
     * $.browser.OS
     *
     * $.browser.aol
     * $.browser.camino
     * $.browser.firefox
     * $.browser.flock
     * $.browser.icab
     * $.browser.konqueror
     * $.browser.mozilla
     * $.browser.msie
     * $.browser.netscape
     * $.browser.opera
     * $.browser.safari
     *
     * $.browser.linux
     * $.browser.mac
     * $.browser.win
     */
	var Public = {
        // The current browser, its version as a number or a string, and the
        // operating system its running on.
          'browser': Private.browser,
          'version': {
              'number': function() { return !arguments.length ? Private.version.number : Math.floor(Private.version.number); },
              'string': function() { return !arguments.length ? Private.version.string : this.number('round').toString(); }
          },
               'OS': Private.OS,

        // A boolean value indicating whether or not the given browser was
        // detected.
              'aol': Private.aol,
           'camino': Private.camino,
          'firefox': Private.firefox,
            'flock': Private.flock,
             'icab': Private.icab,
        'konqueror': Private.konqueror,
          'mozilla': Private.mozilla,
             'msie': Private.msie,
         'netscape': Private.netscape,
            'opera': Private.opera,
           'safari': Private.safari,

        // A boolean value indicating whether or not the given OS was
        // detected.
            'linux': Private.linux,
              'mac': Private.mac,
              'win': Private.win
    };
	
	jQuery.browser = Public;
	// Browser selectors
	if(!add_selectors){return;}
	var bn = jQuery.browser.browser.toLowerCase();
	var bv = jQuery.browser.version.string('round');
	var b = jQuery.browser.msie // IE
						? 'ie ie'+jQuery.browser.version.string('round')
						: (jQuery.browser.firefox || jQuery.browser.camino || jQuery.browser.flock || jQuery.browser.mozilla || jQuery.browser.netscape) // Gecko
							? 'gecko '+ bn + bv + ' ' + bn
								: (jQuery.browser.opera) // Opera
									? 'opera ' + bn + bv
										: (jQuery.browser.safari) // Safari
											? 'safari ' + bn + bv
												: jQuery.browser.konqueror // Konqueror
													? 'konqueror ' + bn + bv
														: jQuery.browser.icab // iCab
															? 'icab ' + bn + bv
																: jQuery.browser.aol // AOL
																 	? 'aol ' + bn + bv
																	: '',
		os=jQuery.browser.linux?'linux':jQuery.browser.mac?'mac':jQuery.browser.win?'win':'';
		jQuery('html').addClass(b).addClass(os).addClass('js');
}();

// file seperator

/*
+-----------------------------------------------------------------------+
| Copyright (c) 2006-2007 Mika Tuupola, Dylan Verheul                   |
| All rights reserved.                                                  |
|                                                                       |
| Redistribution and use in source and binary forms, with or without    |
| modification, are permitted provided that the following conditions    |
| are met:                                                              |
|                                                                       |
| o Redistributions of source code must retain the above copyright      |
|   notice, this list of conditions and the following disclaimer.       |
| o Redistributions in binary form must reproduce the above copyright   |
|   notice, this list of conditions and the following disclaimer in the |
|   documentation and/or other materials provided with the distribution.|
|                                                                       |
| THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS   |
| "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT     |
| LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR |
| A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT  |
| OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, |
| SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT      |
| LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, |
| DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY |
| THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT   |
| (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE |
| OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  |
|                                                                       |
+-----------------------------------------------------------------------+
*/

/* $Id$ */

/**
  * jQuery inplace editor plugin (version 1.3.x)
  *
  * Based on editable by Dylan Verheul <dylan@dyve.net>
  * http://www.dyve.net/jquery/?editable
  *
  * @name  jEditable
  * @type  jQuery
  * @param String  target             POST URL or function name to send edited content
  * @param Hash    options            additional options 
  * @param String  options[name]      POST parameter name of edited content
  * @param String  options[id]        POST parameter name of edited div id
  * @param String  options[type]      text, textarea or select
  * @param Integer options[rows]      number of rows if using textarea
  * @param Integer options[cols]      number of columns if using textarea
  * @param Mixed   options[height]    'auto' or height in pixels
  * @param Mixed   options[width]     'auto' or width in pixels 
  * @param String  options[loadurl]   URL to fetch content before editing
  * @param String  options[loadtype]  Request type for load url. Should be GET or POST.
  * @param String  options[data]      Or content given as paramameter.
  * @param String  options[indicator] indicator html to show when saving
  * @param String  options[tooltip]   optional tooltip text via title attribute
  * @param String  options[event]     jQuery event such as 'click' of 'dblclick'
  * @param String  options[onblur]    'cancel', 'submit' or 'ignore'
  * @param String  options[submit]    submit button value, empty means no button
  * @param String  options[cancel]    cancel button value, empty means no button
  * @param String  options[cssclass]  CSS class to apply to input form. 'inherit' to copy from parent.
  * @param String  options[style]     Style to apply to input form 'inherit' to copy from parent.
  * @param String  options[select]    true or false, when true text is highlighted
  *             
  */

jQuery.fn.editable = function(target, options, callback) {

    /* prevent elem has no properties error */
    if (this.length == 0) { 
        return(this); 
    };
    
    var settings = {
        target   : target,
        name     : 'value',
        id       : 'id',
        type     : 'text',
        width    : 'auto',
        height   : 'auto',
        event    : 'click',
        onblur   : 'cancel',
        loadtype : 'GET'
    };
        
    if(options) {
        jQuery.extend(settings, options);
    };
    
    var callback = callback || function() { };
      
    jQuery(this).attr('title', settings.tooltip);

    jQuery(this)[settings.event](function(e) {

        /* save this to self because this changes when scope changes */
        var self = this;

        /* prevent throwing an exeption if edit field is clicked again */
        if (self.editing) {
            return;
        }

        /* figure out how wide and tall we are */
        var width = 
            ('auto' == settings.width)  ? jQuery(self).width()  : settings.width;
        var height = 
            ('auto' == settings.height) ? jQuery(self).height() : settings.height;

        self.editing    = true;
        self.revert     = jQuery(self).html();
        self.innerHTML  = '';

        /* create the form object */
        var f = document.createElement('form');
        
        /* apply css or style or both */
        if (settings.cssclass) {
            if ('inherit' == settings.cssclass) {
                jQuery(f).attr('class', jQuery(self).attr('class'));
            } else {
                jQuery(f).attr('class', settings.cssclass);
            }
        }
        
        if (settings.style) {
            if ('inherit' == settings.style) {
                jQuery(f).attr('style', jQuery(self).attr('style'));
                /* IE needs the second line or display wont be inherited */
                jQuery(f).css('display', jQuery(self).css('display'));                
            } else {
                jQuery(f).attr('style', settings.style);
            }
        }
        
        /*  main input element */
        var i;
        switch (settings.type) {
            case 'textarea':
                i = document.createElement('textarea');
                if (settings.rows) {
                    i.rows = settings.rows;
                } else {
                    jQuery(i).height(height);
                }
                if (settings.cols) {
                    i.cols = settings.cols;
                } else {
                    jQuery(i).width(width);
                }   
                break;
            case 'select':
                i = document.createElement('select');
                break;
            default:
                i = document.createElement('input');
                i.type  = settings.type;
                jQuery(i).width(width);
                jQuery(i).height(height);
                /* https://bugzilla.mozilla.org/show_bug.cgi?id=236791 */
                i.setAttribute('autocomplete','off');
        }

        /* maintain bc with 1.1.1 and earlier versions */        
        if (settings.getload) {
            settings.loadurl    = settings.getload;
            settings.loadtype = 'GET';
        } else if (settings.postload) {
            settings.loadurl    = settings.postload;
            settings.loadtype = 'POST';
        }

        /* set input content via POST, GET, given data or existing value */
        if (settings.loadurl) {
            var data = {};
            data[settings.id] = self.id;
            jQuery.ajax({
               type : settings.loadtype,
               url  : settings.loadurl,
               data : data,
               success: function(str) {
                  setInputContent(str);
               }
            });
        } else if (settings.data) {
            setInputContent(settings.data);
        } else { 
            setInputContent(self.revert);
        }

        i.name  = settings.name;
        f.appendChild(i);

        if (settings.submit) {
            var b = document.createElement('input');
            b.type = 'submit';
            b.value = settings.submit;
            f.appendChild(b);
        }

        if (settings.cancel) {
            var b = document.createElement('input');
            b.type = 'button';
            b.value = settings.cancel;
            jQuery(b).click(function() {
                reset();
            });
            f.appendChild(b);
        }

        /* add created form to self */
        self.appendChild(f);

        i.focus();
        
        /* highlight input contents when requested */
        if (settings.select) {
            i.select();
        }
         
        /* discard changes if pressing esc */
        jQuery(i).keydown(function(e) {
            if (e.keyCode == 27) {
                e.preventDefault();
                reset();
            }
        });

        /* discard, submit or nothing with changes when clicking outside */
        /* do nothing is usable when navigating with tab */
        var t;
        if ('cancel' == settings.onblur) {
            jQuery(i).blur(function(e) {
                t = setTimeout(reset, 500)
            });
        } else if ('submit' == settings.onblur) {
            jQuery(i).blur(function(e) {
                jQuery(f).submit();
            });
        } else {
            jQuery(i).blur(function(e) {
              /* TODO: maybe something here */
            });
        }

        jQuery(f).submit(function(e) {

            if (t) { 
                clearTimeout(t);
            }

            /* do no submit */
            e.preventDefault(); 

            /* check if given target is function */
            if (jQuery.isFunction(settings.target)) {
                var str = settings.target.apply(self, [jQuery(i).val(), settings]);
                self.innerHTML = str;
                self.editing = false;
                callback.apply(self, [self.innerHTML, settings]);
            } else {
                /* add edited content and id of edited element to POST */           
                var p = {};
                p[i.name] = jQuery(i).val();
                p[settings.id] = self.id;

                /* show the saving indicator */
                jQuery(self).html(settings.indicator);
                jQuery.post(settings.target, p, function(str) {
                    self.innerHTML = str;
                    self.editing = false;
                    callback.apply(self, [self.innerHTML, settings]);
                });
            }
                        
            return false;
        });

        function reset() {
            self.innerHTML = self.revert;
            self.editing   = false;
        };
        
        function setInputContent(str) {
            if (jQuery.isFunction(str)) {
                var str = str.apply(self, [self.revert, settings]);
            }
            switch (settings.type) { 	 
                case 'select': 	 
                    if (String == str.constructor) { 	 
                        eval ("var json = " + str);
                        for (var key in json) {
                            if ('selected' == key) {
                                continue;
                            } 
                            o = document.createElement('option'); 	 
                            o.value = key;
                            var text = document.createTextNode(json[key]);
                            o.appendChild(text);
                            if (key == json['selected']) {
                                o.selected = true;
                            }
                            i.appendChild(o); 	 
                        }
                    } 	 
                    break; 	 
                default: 	 
                    i.value = str; 	 
                    break; 	 
            } 	 
        }

    });

    return(this);
};
// file seperator

(function ($) {
    var m = {
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"' : '\\"',
            '\\': '\\\\'
        },
        s = {
            'array': function (x) {
                var a = ['['], b, f, i, l = x.length, v;
                for (i = 0; i < l; i += 1) {
                    v = x[i];
                    f = s[typeof v];
                    if (f) {
                        v = f(v);
                        if (typeof v == 'string') {
                            if (b) {
                                a[a.length] = ',';
                            }
                            a[a.length] = v;
                            b = true;
                        }
                    }
                }
                a[a.length] = ']';
                return a.join('');
            },
            'boolean': function (x) {
                return String(x);
            },
            'null': function (x) {
                return "null";
            },
            'number': function (x) {
                return isFinite(x) ? String(x) : 'null';
            },
            'object': function (x) {
                if (x) {
                    if (x instanceof Array) {
                        return s.array(x);
                    }
                    var a = ['{'], b, f, i, v;
                    for (i in x) {
                        v = x[i];
                        f = s[typeof v];
                        if (f) {
                            v = f(v);
                            if (typeof v == 'string') {
                                if (b) {
                                    a[a.length] = ',';
                                }
                                a.push(s.string(i), ':', v);
                                b = true;
                            }
                        }
                    }
                    a[a.length] = '}';
                    return a.join('');
                }
                return 'null';
            },
            'string': function (x) {
                if (/["\\\x00-\x1f]/.test(x)) {
                    x = x.replace(/([\x00-\x1f\\"])/g, function(a, b) {
                        var c = m[b];
                        if (c) {
                            return c;
                        }
                        c = b.charCodeAt();
                        return '\\u00' +
                            Math.floor(c / 16).toString(16) +
                            (c % 16).toString(16);
                    });
                }
                return '"' + x + '"';
            }
        };

	$.toJSON = function(v) {
		var f = isNaN(v) ? s[typeof v] : s['number'];
		if (f) return f(v);
	};
	
	$.parseJSON = function(v, safe) {
		if (safe === undefined) safe = $.parseJSON.safe;
		if (safe && !/^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/.test(v))
			return undefined;
		return eval('('+v+')');
	};
	
	$.parseJSON.safe = false;

})(jQuery);

// file seperator

/*
 * jQuery Media Plugin for converting elements into rich media content.
 *
 * Examples and documentation at: http://malsup.com/jquery/media/
 * Copyright (c) 2007 M. Alsup
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 * @author: M. Alsup
 * @version: 0.66 (6/08/2007)
 * @requires jQuery v1.1.2 or later
 *
 * Supported Media Players:
 *    - Flash
 *    - Quicktime
 *    - Real Player
 *    - Silverlight
 *    - Windows Media Player
 *    - iframe
 *
 * Supported Media Formats:
 *   Any types supported by the above players, such as:
 *     Video: asf, avi, flv, mov, mpg, mpeg, mp4, qt, smil, swf, wmv, 3g2, 3gp
 *     Audio: aif, aac, au, gsm, mid, midi, mov, mp3, m4a, snd, rm, wav, wma
 *     Other: bmp, html, pdf, psd, qif, qtif, qti, tif, tiff, xaml
 *
 * Thanks to Mark Hicken for helping me debug this on Safari!
 */
(function($) {

/**
 * Chainable method for converting elements into rich media.
 *
 * @name media
 * @param Object options Options object
 * @param Function callback fn invoked for each matched element before conversion
 * @param Function callback fn invoked for each matched element after conversion
 * @cat Plugins/media
 */
$.fn.media = function(options, f1, f2) {
    return this.each(function() {
        if (typeof options == 'function') {
            f2 = f1;
            f1 = options;
            options = {};
        }
        var o = getSettings(this, options);
        // pre-conversion callback, passes original element and fully populated options
        if (typeof f1 == 'function') f1(this, o);
        
        var r = getTypesRegExp();
        var m = r.exec(o.src) || [''];
        o.type ? m[0] = o.type : m.shift();
        for (var i=0; i < m.length; i++) {
            fn = m[i].toLowerCase();
            if (isDigit(fn[0])) fn = 'fn' + fn; // fns can't begin with numbers
            if (!$.fn.media[fn]) 
                continue;  // unrecognized media type
            // normalize autoplay settings
            var player = $.fn.media[fn+'_player'];
            if (!o.params) o.params = {};
            if (player) {
                var num = player.autoplayAttr == 'autostart';
                o.params[player.autoplayAttr || 'autoplay'] = num ? (o.autoplay ? 1 : 0) : o.autoplay ? true : false;
            }
            var $div = $.fn.media[fn](this, o);

            $div.css('backgroundColor', o.bgColor).width(o.width);
            
            // post-conversion callback, passes original element, new div element and fully populated options
            if (typeof f2 == 'function') f2(this, $div[0], o);
            break;
        }
    });
};

/**
 * Chainable method for preparing elements to display rich media with
 * a page overlay.
 *
 * @name mediabox
 * @param Object options Options object
 * @param Object css values for the media div
 * @cat Plugins/media
 */
$.fn.mediabox = function(options, css) {
    return this.click(function() {
        if (typeof $.blockUI == 'undefined' || typeof $.fn.displayBox == 'undefined') {
            if (typeof $.fn.mediabox.warning != 'undefined') return this; // one warning is enough
            $.fn.mediabox.warning = 1;
            alert('The mediabox method requires blockUI v1.20 or later.');
            return false;
        }
        var o, div=0, $e = $(this).clone();
        $e.appendTo('body').hide().css({margin: 0});
        options = $.extend({}, options, { autoplay: 1 }); // force autoplay in box mode
        $e.media(options, function(){}, function(origEl, newEl, opts) {
            div = newEl;
            o = opts;
        });
        if (!div) return false;
        // don't pull element from the dom on Safari
        var $div = $.browser.safari ? $(div).hide() : $(div).remove();

        if (o.loadingImage)
            $div.css({
                backgroundImage:    'url('+o.loadingImage+')',
                backgroundPosition: 'center center',
                backgroundRepeat:   'no-repeat'
            });
        if (o.boxTitle)
            $div.prepend('<div style="margin:0;padding:0">' + o.boxTitle + '</div>');
        
        if (css) $div.css(css);

        $div.displayBox( { width: o.width, height: o.height }, function(el) {
            // quirkiness; sometimes media doesn't stop when removed from the DOM (especially in IE)
            $(el).find('object,embed').each(function() {
                try { this.Stop();   } catch(e) {}  // quicktime
                try { this.DoStop(); } catch(e) {}  // real
                try { this.controls.stop(); } catch(e) {} // windows media player
            });
        });
        return false;
    });
};

  
/**
 * Non-chainable method for adding or changing file format / player mapping
 * @name mapFormat
 * @param String format File format extension (ie: mov, wav, mp3)
 * @param String player Player name to use for the format (one of: flash, quicktime, realplayer, winmedia, silverlight or iframe
 */
$.fn.media.mapFormat = function(format, player) {
    if (!format || !player || !$.fn.media.defaults.players[player]) return; // invalid
    format = format.toLowerCase();
    if (isDigit(format[0])) format = 'fn' + format;
    $.fn.media[format] = $.fn.media[player];
};


// global defautls; override as needed
$.fn.media.defaults = {
    width:         400,
    height:        400,
    preferMeta:    1,         // true if markup metadata takes precedence over options object
    autoplay:      0,         // normalized cross-player setting
    bgColor:       '#ffffff', // background color
    params:        {},        // added to object element as param elements; added to embed element as attrs
    attrs:         {},        // added to object and embed elements as attrs
    flashvars:     {},        // added to flash content as flashvars param/attr
    flashVersion:  '7',       // required flash version
    
    // MediaBox options
    boxTitle:      null,      // MediaBox titlebar
    loadingImage:  null,      // MediaBox loading indicator
    
    // default flash video and mp3 player (@see: http://jeroenwijering.com/?item=Flash_Media_Player)
    flvPlayer:     'mediaplayer.swf',
    mp3Player:     'mediaplayer.swf',
    
    // @see http://msdn2.microsoft.com/en-us/library/bb412401.aspx
    silverlight: {
        inplaceInstallPrompt: 'true', // display in-place install prompt?
        isWindowless:         'true', // windowless mode (false for wrapping markup)
        framerate:            '24',   // maximum framerate
        version:              '0.9',  // Silverlight version
        onError:              null,   // onError callback
        onLoad:               null,   // onLoad callback
        initParams:           null,   // object init params
        userContext:          null    // callback arg passed to the load callback
    }
};

// Media Players; think twice before overriding
$.fn.media.defaults.players = {
    flash: {
        types:        'flv,mp3,swf',
        oAttrs:   {
            classid:  'clsid:d27cdb6e-ae6d-11cf-96b8-444553540000',
            type:     'application/x-oleobject',
            codebase: 'http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=' + $.fn.media.defaults.flashVersion
        },
        eAttrs: {
            type:         'application/x-shockwave-flash',
            pluginspage:  'http://www.adobe.com/go/getflashplayer'
        }        
    },
    quicktime: {
        types:        'aif,aiff,aac,au,bmp,gsm,mov,mid,midi,mpg,mpeg,mp4,m4a,psd,qt,qtif,qif,qti,snd,tif,tiff,wav,3g2,3gp',
        oAttrs:   {
            classid:  'clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B',
            codebase: 'http://www.apple.com/qtactivex/qtplugin.cab'
        },
        eAttrs: {
            pluginspage:  'http://www.apple.com/quicktime/download/'
        }
    },
    realplayer: {
        types:        'ra,ram,rm,rpm,rv,smi,smil',
        autoplayAttr: 'autostart',
        oAttrs:   {
            classid:  'clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA'
        },
        eAttrs: {
            type:         'audio/x-pn-realaudio-plugin',
            pluginspage:  'http://www.real.com/player/'
        }
    },
    winmedia: {
        types:        'asf,avi,wma,wmv',
        autoplayAttr: 'autostart',
        oUrl:         'url',
        oAttrs:   {
            classid:  'clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6',
            type:     'application/x-oleobject'
        },
        eAttrs: {
            type:         'application/x-mplayer2',
            pluginspage:  'http://www.microsoft.com/Windows/MediaPlayer/'
        }        
    },
    // special cases
    iframe: {
        types: 'html,pdf'
    },
    silverlight: {
        types: 'xaml'
    }
};

//
//  everything below here is private
//


var counter = 1;

for (var player in $.fn.media.defaults.players) {
    var types = $.fn.media.defaults.players[player].types;
    $.each(types.split(','), function(i,o) {
        if (isDigit(o[0])) o = 'fn' + o;
        $.fn.media[o] = $.fn.media[player] = getGenerator(player);
        $.fn.media[o+'_player'] = $.fn.media.defaults.players[player];
    });
};

function getTypesRegExp() {
    var types = '';
    for (var player in $.fn.media.defaults.players) {
        if (types.length) types += ',';
        types += $.fn.media.defaults.players[player].types;
    };
    return new RegExp('\\.(' + types.replace(/,/g,'|') + ')\\b');
};

function getGenerator(player) {
    return function(el, options) {
        return generate(el, options, player);
    };
};

function isDigit(c) {
    return '0123456789'.indexOf(c) > -1;
};

// flatten all possible options: global defaults, meta, option obj
function getSettings(el, options) {
    options = options || {};
    var $el = $(el);
    
    var cls = el.className || '';
    var meta = $.meta ? $el.data() : {};
    var w = meta.width  || parseInt(((cls.match(/w:(\d+)/)||[])[1]||0));
    var h = meta.height || parseInt(((cls.match(/h:(\d+)/)||[])[1]||0));
    if (w) meta.width  = w;
    if (h) meta.height = h;
    if (cls) meta.cls = cls;

    var a = $.fn.media.defaults;
    var b = $.meta && $.fn.media.defaults.preferMeta ? options : meta;
    var c = b == options ? meta : options;

    var p = { params: { bgColor: options.bgColor || $.fn.media.defaults.bgColor } };
    var opts = $.extend({}, a, b, c);
    $.each(['attrs','params','flashvars','silverlight'], function(i,o) {
        opts[o] = $.extend({}, p[o] || {}, a[o] || {}, b[o] || {}, c[o] || {});
    });

    if (typeof opts.caption == 'undefined') opts.caption = $el.text();

    // make sure we have a source!
    opts.src = opts.src || $el.attr('href') || $el.attr('src') || 'unknown';
    return opts;
};

//
//  Flash Player
//

// generate flash using SWFObject if possible
$.fn.media.swf = function(el, opts) {
    if (typeof SWFObject == 'undefined') {
        // roll our own
        if (opts.flashvars) {
            var a = [];
            for (var f in opts.flashvars)
                a.push(f + '=' + opts.flashvars[f]);
            if (!opts.params) opts.params = {};
            opts.params.flashvars = a.join('&');
        }
        return generate(el, opts, 'flash');
    }

    var id = el.id ? (' id="'+el.id+'"') : '';
    var cls = opts.cls ? (' class="' + opts.cls + '"') : '';
    var $div = $('<div' + id + cls + '>');
    $(el).after($div).remove();

    var so = new SWFObject(opts.src, 'movie_player_' + counter++, opts.width, opts.height, opts.flashVersion, opts.bgColor);
    for (var p in opts.params)
        if (p != 'bgColor') so.addParam(p, opts.params[p]);
    for (var f in opts.flashvars)
        so.addVariable(f, opts.flashvars[f]);
    so.write($div[0]);

    if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
    return $div;
};

// map flv and mp3 files to the swf player by default
$.fn.media.flv = $.fn.media.mp3 = function(el, opts) {
    var src = opts.src;
    var player = /\.mp3\b/i.test(src) ? $.fn.media.defaults.mp3Player : $.fn.media.defaults.flvPlayer;
    opts.src = player;
    opts.src = opts.src + '?file=' + src;
    opts.flashvars = $.extend({}, { file: src }, opts.flashvars );
    return $.fn.media.swf(el, opts);
};

//
//  Silverlight
//
$.fn.media.xaml = function(el, opts) {
    if (!window.Sys || !window.Sys.Silverlight) {
        if ($.fn.media.xaml.warning) return;
        $.fn.media.xaml.warning = 1;
        alert('You must include the Silverlight.js script.');
        return;
    }

    var props = {
        width: opts.width,
        height: opts.height,
        background: opts.bgColor,
        inplaceInstallPrompt: opts.silverlight.inplaceInstallPrompt,
        isWindowless: opts.silverlight.isWindowless,
        framerate: opts.silverlight.framerate,
        version: opts.silverlight.version
    };
    var events = {
        onError: opts.silverlight.onError,
        onLoad: opts.silverlight.onLoad
    };

    var id1 = el.id ? (' id="'+el.id+'"') : '';
    var id2 = opts.id || 'AG' + counter++;
    // convert element to div
    var cls = opts.cls ? (' class="' + opts.cls + '"') : '';
    var $div = $('<div' + id1 + cls + '>');
    $(el).after($div).remove();
    
    Sys.Silverlight.createObjectEx({
        source: opts.src,
        initParams: opts.silverlight.initParams,
        userContext: opts.silverlight.userContext,
        id: id2,
        parentElement: $div[0],
        properties: props,
        events: events
    });

    if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
    return $div;
};

//
// generate object/embed markup
//
function generate(el, opts, player) {
    var $el = $(el);
    var o = $.fn.media.defaults.players[player];
    
    if (player == 'iframe') {
        var o = $('<iframe' + ' width="' + opts.width + '" height="' + opts.height + '" >');
        o.attr('src', opts.src);
        o.css('backgroundColor', o.bgColor);
    }
    else if ($.browser.msie) {
        var a = ['<object width="' + opts.width + '" height="' + opts.height + '" '];
        for (var key in opts.attrs)
            a.push(key + '="'+opts.attrs[key]+'" ');
        for (var key in o.oAttrs || {})
            a.push(key + '="'+o.oAttrs[key]+'" ');
        a.push('></ob'+'ject'+'>');
        var p = ['<param name="' + (o.oUrl || 'src') +'" value="' + opts.src + '">'];
        for (var key in opts.params)
            p.push('<param name="'+ key +'" value="' + opts.params[key] + '">');
        var o = document.createElement(a.join(''));
        for (var i=0; i < p.length; i++)
            o.appendChild(document.createElement(p[i]));
    }
    else {
        var a = ['<embed width="' + opts.width + '" height="' + opts.height + '" style="display:block"'];
        if (opts.src) a.push(' src="' + opts.src + '" ');
        for (var key in opts.attrs)
            a.push(key + '="'+opts.attrs[key]+'" ');
        for (var key in o.eAttrs || {})
            a.push(key + '="'+o.eAttrs[key]+'" ');
        for (var key in opts.params)
            a.push(key + '="'+opts.params[key]+'" ');
        a.push('></em'+'bed'+'>');
    }
    // convert element to div
    var id = el.id ? (' id="'+el.id+'"') : '';
    var cls = opts.cls ? (' class="' + opts.cls + '"') : '';
    var $div = $('<div' + id + cls + '>');
    $el.after($div).remove();
    ($.browser.msie || player == 'iframe') ? $div.append(o) : $div.html(a.join(''));
    if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
    return $div;
};


})(jQuery);

// file seperator

/**
 * Tabs - jQuery plugin for accessible, unobtrusive tabs
 * @requires jQuery v1.0.3
 *
 * http://stilbuero.de/tabs/
 *
 * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 * Version: 2.7.3
 */

(function($) { // block scope

$.extend({
    tabs: {
        remoteCount: 0 // TODO in Tabs 3 this is going to be more cleanly in one single namespace
    }
});

/**
 * Create an accessible, unobtrusive tab interface based on a particular HTML structure.
 *
 * The underlying HTML has to look like this:
 *
 * <div id="container">
 *     <ul>
 *         <li><a href="#fragment-1">Section 1</a></li>
 *         <li><a href="#fragment-2">Section 2</a></li>
 *         <li><a href="#fragment-3">Section 3</a></li>
 *     </ul>
 *     <div id="fragment-1">
 *
 *     </div>
 *     <div id="fragment-2">
 *
 *     </div>
 *     <div id="fragment-3">
 *
 *     </div>
 * </div>
 *
 * Each anchor in the unordered list points directly to a section below represented by one of the
 * divs (the URI in the anchor's href attribute refers to the fragment with the corresponding id).
 * Because such HTML structure is fully functional on its own, e.g. without JavaScript, the tab
 * interface is accessible and unobtrusive.
 *
 * A tab is also bookmarkable via hash in the URL. Use the History/Remote plugin (Tabs will
 * auto-detect its presence) to fix the back (and forward) button.
 *
 * @example $('#container').tabs();
 * @desc Create a basic tab interface.
 * @example $('#container').tabs(2);
 * @desc Create a basic tab interface with the second tab initially activated.
 * @example $('#container').tabs({disabled: [3, 4]});
 * @desc Create a tab interface with the third and fourth tab being disabled.
 * @example $('#container').tabs({fxSlide: true});
 * @desc Create a tab interface that uses slide down/up animations for showing/hiding tab
 *       content upon tab switching.
 *
 * @param Number initial An integer specifying the position of the tab (no zero-based index) that
 *                       gets activated at first (on page load). Two alternative ways to specify
 *                       the active tab will overrule this argument. First a li element
 *                       (representing one single tab) belonging to the selected tab class, e.g.
 *                       set the selected tab class (default: "tabs-selected", see option
 *                       selectedClass) for one of the unordered li elements in the HTML source.
 *                       In addition if a fragment identifier/hash in the URL of the page refers
 *                       to the id of a tab container of a tab interface the corresponding tab will
 *                       be activated and both the initial argument as well as an eventually
 *                       declared class attribute will be overruled. Defaults to 1 if omitted.
 * @param Object settings An object literal containing key/value pairs to provide optional settings.
 * @option Array<Number> disabled An array containing the position of the tabs (no zero-based index)
 *                                that should be disabled on initialization. Default value: null.
 *                                A tab can also be disabled by simply adding the disabling class
 *                                (default: "tabs-disabled", see option disabledClass) to the li
 *                                element representing that particular tab.
 * @option Boolean bookmarkable Boolean flag indicating if support for bookmarking and history (via
 *                              changing hash in the URL of the browser) is enabled. Default value:
 *                              false, unless the History/Remote plugin is included. In that case the
 *                              default value becomes true. @see $.ajaxHistory.initialize
 * @option Boolean remote Boolean flag indicating that tab content has to be loaded remotely from
 *                        the url given in the href attribute of the tab menu anchor elements.
 * @option String spinner The content of this string is shown in a tab while remote content is loading.
 *                        Insert plain text as well as an img here. To turn off this notification
 *                        pass an empty string or null. Default: "Loading&#8230;".
 * @option String hashPrefix A String that is used for constructing the hash the link's href attribute
 *                           of a remote tab gets altered to, such as "#remote-1".
 *                           Default value: "remote-tab-".
 * @option Boolean fxFade Boolean flag indicating whether fade in/out animations are used for tab
 *                        switching. Can be combined with fxSlide. Will overrule fxShow/fxHide.
 *                        Default value: false.
 * @option Boolean fxSlide Boolean flag indicating whether slide down/up animations are used for tab
 *                         switching. Can be combined with fxFade. Will overrule fxShow/fxHide.
 *                         Default value: false.
 * @option String|Number fxSpeed A string representing one of the three predefined speeds ("slow",
 *                               "normal", or "fast") or the number of milliseconds (e.g. 1000) to
 *                               run an animation. Default value: "normal".
 * @option Object fxShow An object literal of the form jQuery's animate function expects for making
 *                       your own, custom animation to reveal a tab upon tab switch. Unlike fxFade
 *                       or fxSlide this animation is independent from an optional hide animation.
 *                       Default value: null. @see animate
 * @option Object fxHide An object literal of the form jQuery's animate function expects for making
 *                       your own, custom animation to hide a tab upon tab switch. Unlike fxFade
 *                       or fxSlide this animation is independent from an optional show animation.
 *                       Default value: null. @see animate
 * @option String|Number fxShowSpeed A string representing one of the three predefined speeds
 *                                   ("slow", "normal", or "fast") or the number of milliseconds
 *                                   (e.g. 1000) to run the animation specified in fxShow.
 *                                   Default value: fxSpeed.
 * @option String|Number fxHideSpeed A string representing one of the three predefined speeds
 *                                   ("slow", "normal", or "fast") or the number of milliseconds
 *                                   (e.g. 1000) to run the animation specified in fxHide.
 *                                   Default value: fxSpeed.
 * @option Boolean fxAutoHeight Boolean flag that if set to true causes all tab heights
 *                              to be constant (being the height of the tallest tab).
 *                              Default value: false.
 * @option Function onClick A function to be invoked upon tab switch, immediatly after a tab has
 *                          been clicked, e.g. before the other's tab content gets hidden. The
 *                          function gets passed three arguments: the first one is the clicked
 *                          tab (e.g. an anchor element), the second one is the DOM element
 *                          containing the content of the clicked tab (e.g. the div), the third
 *                          argument is the one of the tab that gets hidden. If this callback
 *                          returns false, the tab switch is canceled (use to disallow tab
 *                          switching for the reason of a failed form validation for example).
 *                          Default value: null.
 * @option Function onHide A function to be invoked upon tab switch, immediatly after one tab's
 *                         content got hidden (with or without an animation) and right before the
 *                         next tab is revealed. The function gets passed three arguments: the
 *                         first one is the clicked tab (e.g. an anchor element), the second one
 *                         is the DOM element containing the content of the clicked tab, (e.g. the
 *                         div), the third argument is the one of the tab that gets hidden.
 *                         Default value: null.
 * @option Function onShow A function to be invoked upon tab switch. This function is invoked
 *                         after the new tab has been revealed, e.g. after the switch is completed.
 *                         The function gets passed three arguments: the first one is the clicked
 *                         tab (e.g. an anchor element), the second one is the DOM element
 *                         containing the content of the clicked tab, (e.g. the div), the third
 *                         argument is the one of the tab that gets hidden. Default value: null.
 * @option String navClass A CSS class that is used to identify the tabs unordered list by class if
 *                         the required HTML structure differs from the default one.
 *                         Default value: "tabs-nav".
 * @option String selectedClass The CSS class attached to the li element representing the
 *                              currently selected (active) tab. Default value: "tabs-selected".
 * @option String disabledClass The CSS class attached to the li element representing a disabled
 *                              tab. Default value: "tabs-disabled".
 * @option String containerClass A CSS class that is used to identify tab containers by class if
 *                               the required HTML structure differs from the default one.
 *                               Default value: "tabs-container".
 * @option String hideClass The CSS class used for hiding inactive tabs. A class is used instead
 *                          of "display: none" in the style attribute to maintain control over
 *                          visibility in other media types than screen, most notably print.
 *                          Default value: "tabs-hide".
 * @option String loadingClass The CSS class used for indicating that an Ajax tab is currently
 *                             loading, for example by showing a spinner.
 *                             Default value: "tabs-loading".
 * @option String tabStruct @deprecated A CSS selector or basic XPath expression reflecting a
 *                          nested HTML structure that is different from the default single div
 *                          structure (one div with an id inside the overall container holds one
 *                          tab's content). If for instance an additional div is required to wrap
 *                          up the several tab containers such a structure is expressed by "div>div".
 *                          Default value: "div".
 * @type jQuery
 *
 * @name tabs
 * @cat Plugins/Tabs
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */
$.fn.tabs = function(initial, settings) {

    // settings
    if (typeof initial == 'object') settings = initial; // no initial tab given but a settings object
    settings = $.extend({
        initial: (initial && typeof initial == 'number' && initial > 0) ? --initial : 0,
        disabled: null,
        bookmarkable: $.ajaxHistory ? true : false,
        remote: false,
        spinner: 'Loading&#8230;',
        hashPrefix: 'remote-tab-',
        fxFade: null,
        fxSlide: null,
        fxShow: null,
        fxHide: null,
        fxSpeed: 'normal',
        fxShowSpeed: null,
        fxHideSpeed: null,
        fxAutoHeight: false,
        onClick: null,
        onHide: null,
        onShow: null,
        navClass: 'tabs-nav',
        selectedClass: 'tabs-selected',
        disabledClass: 'tabs-disabled',
        containerClass: 'tabs-container',
        hideClass: 'tabs-hide',
        loadingClass: 'tabs-loading',
        tabStruct: 'div'
    }, settings || {});

    $.browser.msie6 = $.browser.msie6 || $.browser.msie && typeof XMLHttpRequest == 'function';

    // helper to prevent scroll to fragment
    function unFocus() {
        scrollTo(0, 0);
    }

    // initialize tabs
    return this.each(function() {

        // remember wrapper for later
        var container = this;

        // setup nav
        var nav = $('ul.' + settings.navClass, container);
        nav = nav.size() && nav || $('>ul:eq(0)', container); // fallback to default structure
        var tabs = $('a', nav);

        // prepare remote tabs
        if (settings.remote) {
            tabs.each(function() {
                var id = settings.hashPrefix + (++$.tabs.remoteCount), hash = '#' + id, url = this.href;
                this.href = hash;
                $('<div id="' + id + '" class="' + settings.containerClass + '"></div>').appendTo(container);

                $(this).bind('loadRemoteTab', function(e, callback) {
                    var $$ = $(this).addClass(settings.loadingClass), span = $('span', this)[0], tabTitle = span.innerHTML;
                    if (settings.spinner) {
                        // TODO if spinner is image
                        span.innerHTML = '<em>' + settings.spinner + '</em>'; // WARNING: html(...) crashes Safari with jQuery 1.1.2
                    }
                    setTimeout(function() { // Timeout is again required in IE, "wait" for id being restored
                        $(hash).load(url, function() {
                            if (settings.spinner) {
                                span.innerHTML = tabTitle; // WARNING: html(...) crashes Safari with jQuery 1.1.2
                            }
                            $$.removeClass(settings.loadingClass);
                            callback && callback();
                        });
                    }, 0);
                });

            });
        }

        // set up containers
        var containers = $('div.' + settings.containerClass, container);
        containers = containers.size() && containers || $('>' + settings.tabStruct, container); // fallback to default structure

        // attach classes for styling if not present
        nav.is('.' + settings.navClass) || nav.addClass(settings.navClass);
        containers.each(function() {
            var $$ = $(this);
            $$.is('.' + settings.containerClass) || $$.addClass(settings.containerClass);
        });

        // try to retrieve active tab from class in HTML
        var hasSelectedClass = $('li', nav).index( $('li.' + settings.selectedClass, nav)[0] );
        if (hasSelectedClass >= 0) {
           settings.initial = hasSelectedClass;
        }

        // try to retrieve active tab from hash in url, will override class in HTML
        if (location.hash) {
            tabs.each(function(i) {
                if (this.hash == location.hash) {
                    settings.initial = i;
                    // prevent page scroll to fragment
                    if (($.browser.msie || $.browser.opera) && !settings.remote) {
                        var toShow = $(location.hash);
                        var toShowId = toShow.attr('id');
                        toShow.attr('id', '');
                        setTimeout(function() {
                            toShow.attr('id', toShowId); // restore id
                        }, 500);
                    }
                    unFocus();
                    return false; // break
                }
            });
        }
        if ($.browser.msie) {
            unFocus(); // fix IE focussing bottom of the page for some unknown reason
        }

        // highlight tab accordingly
        containers.filter(':eq(' + settings.initial + ')').show().end().not(':eq(' + settings.initial + ')').addClass(settings.hideClass);
        $('li', nav).removeClass(settings.selectedClass).eq(settings.initial).addClass(settings.selectedClass); // we need to remove classes eventually if hash takes precedence over class
        // trigger load of initial tab
        tabs.eq(settings.initial).trigger('loadRemoteTab').end();

        // setup auto height
        if (settings.fxAutoHeight) {
            // helper
            var _setAutoHeight = function(reset) {
                // get tab heights in top to bottom ordered array
                var heights = $.map(containers.get(), function(el) {
                    var h, jq = $(el);
                    if (reset) {
                        if ($.browser.msie6) {
                            el.style.removeExpression('behaviour');
                            el.style.height = '';
                            el.minHeight = null;
                        }
                        h = jq.css({'min-height': ''}).height(); // use jQuery's height() to get hidden element values
                    } else {
                        h = jq.height(); // use jQuery's height() to get hidden element values
                    }
                    return h;
                }).sort(function(a, b) {
                    return b - a;
                });
                if ($.browser.msie6) {
                    containers.each(function() {
                        this.minHeight = heights[0] + 'px';
                        this.style.setExpression('behaviour', 'this.style.height = this.minHeight ? this.minHeight : "1px"'); // using an expression to not make print styles useless
                    });
                } else {
                    containers.css({'min-height': heights[0] + 'px'});
                }
            };
            // call once for initialization
            _setAutoHeight();
            // trigger auto height adjustment if needed
            var cachedWidth = container.offsetWidth;
            var cachedHeight = container.offsetHeight;
            var watchFontSize = $('#tabs-watch-font-size').get(0) || $('<span id="tabs-watch-font-size">M</span>').css({display: 'block', position: 'absolute', visibility: 'hidden'}).appendTo(document.body).get(0);
            var cachedFontSize = watchFontSize.offsetHeight;
            setInterval(function() {
                var currentWidth = container.offsetWidth;
                var currentHeight = container.offsetHeight;
                var currentFontSize = watchFontSize.offsetHeight;
                if (currentHeight > cachedHeight || currentWidth != cachedWidth || currentFontSize != cachedFontSize) {
                    _setAutoHeight((currentWidth > cachedWidth || currentFontSize < cachedFontSize)); // if heights gets smaller reset min-height
                    cachedWidth = currentWidth;
                    cachedHeight = currentHeight;
                    cachedFontSize = currentFontSize;
                }
            }, 50);
        }

        // setup animations
        var showAnim = {}, hideAnim = {}, showSpeed = settings.fxShowSpeed || settings.fxSpeed, hideSpeed = settings.fxHideSpeed || settings.fxSpeed;
        if (settings.fxSlide || settings.fxFade) {
            if (settings.fxSlide) {
                showAnim['height'] = 'show';
                hideAnim['height'] = 'hide';
            }
            if (settings.fxFade) {
                showAnim['opacity'] = 'show';
                hideAnim['opacity'] = 'hide';
            }
        } else {
            if (settings.fxShow) {
                showAnim = settings.fxShow;
            } else { // use some kind of animation to prevent browser scrolling to the tab
                showAnim['min-width'] = 0; // avoid opacity, causes flicker in Firefox
                showSpeed = settings.bookmarkable ? 50 : 1; // as little as 50 is sufficient
            }
            if (settings.fxHide) {
                hideAnim = settings.fxHide;
            } else { // use some kind of animation to prevent browser scrolling to the tab
                hideAnim['min-width'] = 0; // avoid opacity, causes flicker in Firefox
                hideSpeed = settings.bookmarkable ? 50 : 1; // as little as 50 is sufficient
            }
        }

        // callbacks
        var onClick = settings.onClick, onHide = settings.onHide, onShow = settings.onShow;

        // attach activateTab event, required for activating a tab programmatically
        tabs.bind('triggerTab', function() {

            // if the tab is already selected or disabled or animation is still running stop here
            var li = $(this).parents('li:eq(0)');
            if (container.locked || li.is('.' + settings.selectedClass) || li.is('.' + settings.disabledClass)) {
                return false;
            }

            var hash = this.hash;

            if ($.browser.msie) {

                $(this).trigger('click');
                if (settings.bookmarkable) {
                    $.ajaxHistory.update(hash);
                    location.hash = hash.replace('#', '');
                }

            } else if ($.browser.safari) {

                // Simply setting location.hash puts Safari into the eternal load state... ugh! Submit a form instead.
                var tempForm = $('<form action="' + hash + '"><div><input type="submit" value="h" /></div></form>').get(0); // no need to append it to the body
                tempForm.submit(); // does not trigger the form's submit event...
                $(this).trigger('click'); // ...thus do stuff here
                if (settings.bookmarkable) {
                    $.ajaxHistory.update(hash);
                }

            } else {

                if (settings.bookmarkable) {
                    location.hash = hash.replace('#', '');
                } else {
                    $(this).trigger('click');
                }

            }

        });

        // attach disable event, required for disabling a tab
        tabs.bind('disableTab', function() {
            var li = $(this).parents('li:eq(0)');
            if ($.browser.safari) { /* Fix opacity of tab after disabling in Safari... */
                li.animate({ opacity: 0 }, 1, function() {
                   li.css({opacity: ''});
                });
            }
            li.addClass(settings.disabledClass);

        });

        // disabled from settings
        if (settings.disabled && settings.disabled.length) {
            for (var i = 0, k = settings.disabled.length; i < k; i++) {
                tabs.eq(--settings.disabled[i]).trigger('disableTab').end();
            }
        };

        // attach enable event, required for reenabling a tab
        tabs.bind('enableTab', function() {
            var li = $(this).parents('li:eq(0)');
            li.removeClass(settings.disabledClass);
            if ($.browser.safari) { /* Fix disappearing tab after enabling in Safari... */
                li.animate({ opacity: 1 }, 1, function() {
                    li.css({opacity: ''});
                });
            }
        });

        // attach click event
        tabs.bind('click', function(e) {

            var trueClick = e.clientX; // add to history only if true click occured, not a triggered click
            var clicked = this, li = $(this).parents('li:eq(0)'), toShow = $(this.hash), toHide = containers.filter(':visible');

            // if animation is still running, tab is selected or disabled or onClick callback returns false stop here
            // check if onClick returns false last so that it is not executed for a disabled tab
            if (container['locked'] || li.is('.' + settings.selectedClass) || li.is('.' + settings.disabledClass) || typeof onClick == 'function' && onClick(this, toShow[0], toHide[0]) === false) {
                this.blur();
                return false;
            }

            container['locked'] = true;

            // show new tab
            if (toShow.size()) {

                // prevent scrollbar scrolling to 0 and than back in IE7, happens only if bookmarking/history is enabled
                if ($.browser.msie && settings.bookmarkable) {
                    var toShowId = this.hash.replace('#', '');
                    toShow.attr('id', '');
                    setTimeout(function() {
                        toShow.attr('id', toShowId); // restore id
                    }, 0);
                }

                // switch tab, animation prevents browser scrolling to the fragment
                function switchTab() {
                    if (settings.bookmarkable && trueClick) { // add to history only if true click occured, not a triggered click
                        $.ajaxHistory.update(clicked.hash);
                    }
                    toHide.animate(hideAnim, hideSpeed, function() { //
                        $(clicked).parents('li:eq(0)').addClass(settings.selectedClass).siblings().removeClass(settings.selectedClass);
                        if (typeof onHide == 'function') {
                            onHide(clicked, toShow[0], toHide[0]);
                        }
                        var resetCSS = { display: '', overflow: '', height: '' };
                        if (!$.browser.msie) { // not in IE to prevent ClearType font issue
                            resetCSS['opacity'] = '';
                        }
                        toHide.addClass(settings.hideClass).css(resetCSS); // maintain flexible height and accessibility in print etc.
                        toShow.removeClass(settings.hideClass).animate(showAnim, showSpeed, function() {
                            toShow.css(resetCSS); // maintain flexible height and accessibility in print etc.
                            if ($.browser.msie) {
                                toHide[0].style.filter = '';
                                toShow[0].style.filter = '';
                            }
                            if (typeof onShow == 'function') {
                                onShow(clicked, toShow[0], toHide[0]);
                            }
                            container['locked'] = null;
                        });
                    });
                }

                if (!settings.remote) {
                    switchTab();
                } else {
                    $(clicked).trigger('loadRemoteTab', [switchTab]);
                }

            } else {
                alert('There is no such container.');
            }

            // Set scrollbar to saved position - need to use timeout with 0 to prevent browser scroll to target of hash
            var scrollX = window.pageXOffset || document.documentElement && document.documentElement.scrollLeft || document.body.scrollLeft || 0;
            var scrollY = window.pageYOffset || document.documentElement && document.documentElement.scrollTop || document.body.scrollTop || 0;
            setTimeout(function() {
                window.scrollTo(scrollX, scrollY);
            }, 0);

            this.blur(); // prevent IE from keeping other link focussed when using the back button

            return settings.bookmarkable && !!trueClick; // convert undefined to Boolean for IE

        });

        // enable history support if bookmarking and history is turned on
        if (settings.bookmarkable) {
            $.ajaxHistory.initialize(function() {
                tabs.eq(settings.initial).trigger('click').end();
            });
        }

    });

};

/**
 * Activate a tab programmatically with the given position (no zero-based index)
 * or its id, e.g. the URL's fragment identifier/hash representing a tab, as if the tab
 * itself were clicked.
 *
 * @example $('#container').triggerTab(2);
 * @desc Activate the second tab of the tab interface contained in <div id="container">.
 * @example $('#container').triggerTab(1);
 * @desc Activate the first tab of the tab interface contained in <div id="container">.
 * @example $('#container').triggerTab();
 * @desc Activate the first tab of the tab interface contained in <div id="container">.
 * @example $('#container').triggerTab('fragment-2');
 * @desc Activate a tab via its URL fragment identifier representation.
 *
 * @param String|Number tab Either a string that matches the id of the tab (the URL's
 *                          fragment identifier/hash representing a tab) or an integer
 *                          specifying the position of the tab (no zero-based index) to
 *                          be activated. If this parameter is omitted, the first tab
 *                          will be activated.
 * @type jQuery
 *
 * @name triggerTab
 * @cat Plugins/Tabs
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */

/**
 * Disable a tab, so that clicking it has no effect.
 *
 * @example $('#container').disableTab(2);
 * @desc Disable the second tab of the tab interface contained in <div id="container">.
 *
 * @param String|Number tab Either a string that matches the id of the tab (the URL's
 *                          fragment identifier/hash representing a tab) or an integer
 *                          specifying the position of the tab (no zero-based index) to
 *                          be disabled. If this parameter is omitted, the first tab
 *                          will be disabled.
 * @type jQuery
 *
 * @name disableTab
 * @cat Plugins/Tabs
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */

/**
 * Enable a tab that has been disabled.
 *
 * @example $('#container').enableTab(2);
 * @desc Enable the second tab of the tab interface contained in <div id="container">.
 *
 * @param String|Number tab Either a string that matches the id of the tab (the URL's
 *                          fragment identifier/hash representing a tab) or an integer
 *                          specifying the position of the tab (no zero-based index) to
 *                          be enabled. If this parameter is omitted, the first tab
 *                          will be enabled.
 * @type jQuery
 *
 * @name enableTab
 * @cat Plugins/Tabs
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */

var tabEvents = ['triggerTab', 'disableTab', 'enableTab'];
for (var i = 0; i < tabEvents.length; i++) {
    $.fn[tabEvents[i]] = (function(tabEvent) {
        return function(tab) {
            return this.each(function() {
                var nav = $('ul.tabs-nav' , this);
                nav = nav.size() && nav || $('>ul:eq(0)', this); // fallback to default structure
                var a;
                if (!tab || typeof tab == 'number') {
                    a = $('li a', nav).eq((tab && tab > 0 && tab - 1 || 0)); // fall back to 0
                } else if (typeof tab == 'string') {
                    a = $('li a[@href$="#' + tab + '"]', nav);
                }
                a.trigger(tabEvent);
            });
        };
    })(tabEvents[i]);
}

/**
 * Get the position of the currently selected tab (no zero-based index).
 *
 * @example $('#container').activeTab();
 * @desc Get the position of the currently selected tab of an interface
 * contained in <div id="container">.
 *
 * @type Number
 *
 * @name activeTab
 * @cat Plugins/Tabs
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */

$.fn.activeTab = function() {
    var selectedTabs = [];
    this.each(function() {
        var nav = $('ul.tabs-nav' , this);
        nav = nav.size() && nav || $('>ul:eq(0)', this); //fallback to default structure
        var lis = $('li', nav);
        selectedTabs.push(lis.index( lis.filter('.tabs-selected')[0] ) + 1);
    });
    return selectedTabs[0];
};

})(jQuery);
// file seperator



/*
Class: Class
	The base class object of the <http://mootools.net> framework.
	
Arguments:
	properties - the collection of properties that apply to the class. Creates a new class, its initialize method will fire upon class instantiation.
	
Example:
	>var Cat = new Class({
	>	initialize: function(name){
	>		this.name = name;
	>	}
	>});
	>var myCat = new Cat('Micia');
	>alert myCat.name; //alerts 'Micia'
*/

var Class = function(properties){
	var klass = function(){
		for (var p in this){
			if (this[p]) this[p]._proto_ = this;
		}
		if (arguments[0] != 'noinit' && this.initialize) return this.initialize.apply(this, arguments);
	};
	klass.extend = this.extend;
	klass.implement = this.implement;
	klass.prototype = properties;
	return klass;
};

/*
Property: empty
	Returns an empty function
*/

Class.empty = function(){};

/*
Property: create
	same as new Class. see <Class>
*/

Class.create = function(properties){
	return new Class(properties);
};

Class.prototype = {

	/*
	Property: extend
		Returns the copy of the Class extended with the passed in properties.
		
	Arguments:
		properties - the properties to add to the base class in this new Class.
		
	Example:
		>var Animal = new Class({
		>	initialize: function(age){
		>		this.age = age;
		>	}
		>});
		>var Cat = Animal.extend({
		>	initialize: function(name, age){
		>		this.parent(age); //will call the previous initialize;
		>		this.name = name;
		>	}
		>});
		>var myCat = new Cat('Micia', 20);
		>alert myCat.name; //alerts 'Micia'
		>alert myCat.age; //alerts 20
	*/

	extend: function(properties){
		var pr0t0typ3 = new this('noinit');
		for (var property in properties){
			var previous = pr0t0typ3[property];
			var current = properties[property];
			if (previous && previous != current) current = previous.parentize(current) || current;
			pr0t0typ3[property] = current;
		}
		return new Class(pr0t0typ3);
	},
	
	/*	
	Property: implement
		Implements the passed in properties to the base Class prototypes, altering the base class, unlike <Class.extend>.

	Arguments:
		properties - the properties to add to the base class.
		
	Example:
		>var Animal = new Class({
		>	initialize: function(age){
		>		this.age = age;
		>	}
		>});
		>Animal.implement({
		>	setName: function(name){
		>		this.name = name
		>	}
		>});
		>var myAnimal = new Animal(20);
		>myAnimal.setName('Micia');
		>alert(myAnimal.name); //alerts 'Micia'
	*/
	
	implement: function(properties){
		for (var property in properties) this.prototype[property] = properties[property];
	}

};

/*
Function: Object.Native
	Will add a .extend method to the objects passed as a parameter, equivalent to <Class.implement>

Arguments:
	a number of classes/native javascript objects

*/

Object.Native = function(){
	for (var i = 0; i < arguments.length; i++) arguments[i].extend = Class.prototype.implement;
};

new Object.Native(Function, Array, String, Number);

Function.extend({

	parentize: function(current){
		var previous = this;
		return function(){
			this.parent = previous;
			return current.apply(this, arguments);
		};
	}

});
// file seperator

/**
 * SWFObject v1.4.4: Flash Player detection and embed - http://blog.deconcept.com/swfobject/
 *
 * SWFObject is (c) 2006 Geoff Stearns and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * **SWFObject is the SWF embed script formerly known as FlashObject. The name was changed for
 *   legal reasons.
 */
if(typeof deconcept=="undefined"){var deconcept=new Object();}
if(typeof deconcept.util=="undefined"){deconcept.util=new Object();}
if(typeof deconcept.SWFObjectUtil=="undefined"){deconcept.SWFObjectUtil=new Object();}
deconcept.SWFObject=function(_1,id,w,h,_5,c,_7,_8,_9,_a,_b){if(!document.getElementById){return;}
this.DETECT_KEY=_b?_b:"detectflash";
this.skipDetect=deconcept.util.getRequestParameter(this.DETECT_KEY);
this.params=new Object();
this.variables=new Object();
this.attributes=new Array();
if(_1){this.setAttribute("swf",_1);}
if(id){this.setAttribute("id",id);}
if(w){this.setAttribute("width",w);}
if(h){this.setAttribute("height",h);}
if(_5){this.setAttribute("version",new deconcept.PlayerVersion(_5.toString().split(".")));}
this.installedVer=deconcept.SWFObjectUtil.getPlayerVersion();
if(c){this.addParam("bgcolor",c);}
var q=_8?_8:"high";
this.addParam("quality",q);
this.setAttribute("useExpressInstall",_7);
this.setAttribute("doExpressInstall",false);
var _d=(_9)?_9:window.location;
this.setAttribute("xiRedirectUrl",_d);
this.setAttribute("redirectUrl","");
if(_a){this.setAttribute("redirectUrl",_a);}};
deconcept.SWFObject.prototype={setAttribute:function(_e,_f){
this.attributes[_e]=_f;
},getAttribute:function(_10){
return this.attributes[_10];
},addParam:function(_11,_12){
this.params[_11]=_12;
},getParams:function(){
return this.params;
},addVariable:function(_13,_14){
this.variables[_13]=_14;
},getVariable:function(_15){
return this.variables[_15];
},getVariables:function(){
return this.variables;
},getVariablePairs:function(){
var _16=new Array();
var key;
var _18=this.getVariables();
for(key in _18){_16.push(key+"="+_18[key]);}
return _16;},getSWFHTML:function(){var _19="";
if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){
if(this.getAttribute("doExpressInstall")){
this.addVariable("MMplayerType","PlugIn");}
_19="<embed type=\"application/x-shockwave-flash\" src=\""+this.getAttribute("swf")+"\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\"";
_19+=" id=\""+this.getAttribute("id")+"\" name=\""+this.getAttribute("id")+"\" ";
var _1a=this.getParams();
for(var key in _1a){_19+=[key]+"=\""+_1a[key]+"\" ";}
var _1c=this.getVariablePairs().join("&");
if(_1c.length>0){_19+="flashvars=\""+_1c+"\"";}_19+="/>";
}else{if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","ActiveX");}
_19="<object id=\""+this.getAttribute("id")+"\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\">";
_19+="<param name=\"movie\" value=\""+this.getAttribute("swf")+"\" />";
var _1d=this.getParams();
for(var key in _1d){_19+="<param name=\""+key+"\" value=\""+_1d[key]+"\" />";}
var _1f=this.getVariablePairs().join("&");
if(_1f.length>0){_19+="<param name=\"flashvars\" value=\""+_1f+"\" />";}_19+="</object>";}
return _19;
},write:function(_20){
if(this.getAttribute("useExpressInstall")){
var _21=new deconcept.PlayerVersion([6,0,65]);
if(this.installedVer.versionIsValid(_21)&&!this.installedVer.versionIsValid(this.getAttribute("version"))){
this.setAttribute("doExpressInstall",true);
this.addVariable("MMredirectURL",escape(this.getAttribute("xiRedirectUrl")));
document.title=document.title.slice(0,47)+" - Flash Player Installation";
this.addVariable("MMdoctitle",document.title);}}
if(this.skipDetect||this.getAttribute("doExpressInstall")||this.installedVer.versionIsValid(this.getAttribute("version"))){
var n=(typeof _20=="string")?document.getElementById(_20):_20;
n.innerHTML=this.getSWFHTML();return true;
}else{if(this.getAttribute("redirectUrl")!=""){document.location.replace(this.getAttribute("redirectUrl"));}}
return false;}};
deconcept.SWFObjectUtil.getPlayerVersion=function(){
var _23=new deconcept.PlayerVersion([0,0,0]);
if(navigator.plugins&&navigator.mimeTypes.length){
var x=navigator.plugins["Shockwave Flash"];
if(x&&x.description){_23=new deconcept.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."));}
}else{try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");}
catch(e){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");
_23=new deconcept.PlayerVersion([6,0,21]);axo.AllowScriptAccess="always";}
catch(e){if(_23.major==6){return _23;}}try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");}
catch(e){}}if(axo!=null){_23=new deconcept.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));}}
return _23;};
deconcept.PlayerVersion=function(_27){
this.major=_27[0]!=null?parseInt(_27[0]):0;
this.minor=_27[1]!=null?parseInt(_27[1]):0;
this.rev=_27[2]!=null?parseInt(_27[2]):0;
};
deconcept.PlayerVersion.prototype.versionIsValid=function(fv){
if(this.major<fv.major){return false;}
if(this.major>fv.major){return true;}
if(this.minor<fv.minor){return false;}
if(this.minor>fv.minor){return true;}
if(this.rev<fv.rev){
return false;
}return true;};
deconcept.util={getRequestParameter:function(_29){
var q=document.location.search||document.location.hash;
if(q){var _2b=q.substring(1).split("&");
for(var i=0;i<_2b.length;i++){
if(_2b[i].substring(0,_2b[i].indexOf("="))==_29){
return _2b[i].substring((_2b[i].indexOf("=")+1));}}}
return "";}};
deconcept.SWFObjectUtil.cleanupSWFs=function(){if(window.opera||!document.all){return;}
var _2d=document.getElementsByTagName("OBJECT");
for(var i=0;i<_2d.length;i++){_2d[i].style.display="none";for(var x in _2d[i]){
if(typeof _2d[i][x]=="function"){_2d[i][x]=function(){};}}}};
deconcept.SWFObjectUtil.prepUnload=function(){__flash_unloadHandler=function(){};
__flash_savedUnloadHandler=function(){};
if(typeof window.onunload=="function"){
var _30=window.onunload;
window.onunload=function(){
deconcept.SWFObjectUtil.cleanupSWFs();_30();};
}else{window.onunload=deconcept.SWFObjectUtil.cleanupSWFs;}};
if(typeof window.onbeforeunload=="function"){
var oldBeforeUnload=window.onbeforeunload;
window.onbeforeunload=function(){
deconcept.SWFObjectUtil.prepUnload();
oldBeforeUnload();};
}else{window.onbeforeunload=deconcept.SWFObjectUtil.prepUnload;}
if(Array.prototype.push==null){
Array.prototype.push=function(_31){
this[this.length]=_31;
return this.length;};}
var getQueryParamValue=deconcept.util.getRequestParameter;
var FlashObject=deconcept.SWFObject;
var SWFObject=deconcept.SWFObject;

// file seperator

$ = null;
var _$J = jQuery;

Function.prototype.extendNativeFunctionObject = jQuery.extend;

jQuery.getOne = function(s, context) {
	var rt;

	if (typeof s == 'object') {
		rt = s;
	}
	else if (typeof s == 'string') {
		if (s.search(/^[#.]/) == -1) {
			s = '#' + s;
		}

		if (context == null) {
			rt = jQuery(s);
		}
		else {
			rt = jQuery(s, context);
		}

		if (rt.length > 0) {
			rt = rt.get(0);
		}
		else {
			rt = null;
		}
	}

	return rt;
};

jQuery.fn.getOne = function(s) {
	return jQuery.getOne(s, this);
};

Liferay = function() {
	var $ = jQuery;

	return {};
}();

jQuery.fn.exactHeight = jQuery.fn.height;
jQuery.fn.exactWidth = jQuery.fn.width;

jQuery.each( [ 'height', 'width' ], function(i,n){
	jQuery.fn[ n ] = function(h) {
		return h == undefined ?
			( this.length ? (n == 'height' ? this[0].offsetHeight : this[0].offsetWidth) : null ) :
			this.css( n, h.constructor == String ? h : h + "px" );
	};
});
// file seperator

Liferay.Browser = {

	init: function() {
		var instance = this;

		var version = instance.version();
		var exactVersion = instance.version(true);

		instance._browserVars = {
			agent: '',

			is_ie: false,
			is_ie_4: false,
			is_ie_5: false,
			is_ie_5_5: false,
			is_ie_5_up: false,
			is_ie_6: false,
			is_ie_7: false,

			is_mozilla: false,
			is_mozilla_1_3_up: false,

			is_ns_4: false,

			is_rtf: false,

			is_safari: false,
			is_opera: false
		};

		instance._browserVars.agent = instance.browser().toLowerCase();

		instance._browserVars.is_ie = jQuery.browser.msie;
		instance._browserVars.is_ie_4 = (instance.is_ie && version == 4);
		instance._browserVars.is_ie_5 = (instance.is_ie && version == 5);
		instance._browserVars.is_ie_5_5 = (instance.is_ie && exactVersion == 5.5);
		instance._browserVars.is_ie_5_up = (instance.is_ie && version >= 5);
		instance._browserVars.is_ie_6 = (instance.is_ie && version == 6);
		instance._browserVars.is_ie_7 = (instance.is_ie && version == 7);

		instance._browserVars.is_mozilla = (jQuery.browser.firefox || jQuery.browser.camino || jQuery.browser.flock || jQuery.browser.mozilla || jQuery.browser.netscape);
		instance._browserVars.is_mozilla_1_3_up = (instance.is_mozilla && exactVersion > 1.3);

		instance._browserVars.is_ns_4 = (jQuery.browser.netscape && version == 4);

		instance._browserVars.is_rtf = (instance.is_ie_5_5_up || instance.is_mozilla_1_3_up);

		instance._browserVars.is_safari = jQuery.browser.safari;
		instance._browserVars.is_opera = jQuery.browser.opera;

		jQuery.extend(instance, instance._browserVars);
	},

	browser: function() {
		var instance = this;

		return jQuery.browser.browser;
	},

	compat: function() {
		var instance = this;

		for (var i in instance._browserVars){
			if (!window[i]) {
				window[i] = instance._browserVars[i];
			}
		}
	},

	version: function(exact) {
		var instance = this;

		if (!exact) {
			return jQuery.browser.version.string(true);
		}
		else {
			return jQuery.browser.version.string();
		}
	},

	_browserVars: {}
};

jQuery(
	function() {
		Liferay.Browser.init();
		//Uncomment the following line if you wish to have the original global variables set (eg. is_ie6, is_mozilla, etc)
		// Liferay.Browser.compat();
	}
);
// file seperator

Liferay.Util = {
	submitCountdown: 0,

	actsAsAspect: function(object) {
		object.yield = null;
		object.rv = {};

		object.before = function(method, f) {
			var original = eval("this." + method);

			this[method] = function() {
				f.apply(this, arguments);

				return original.apply(this, arguments);
			};
		};

		object.after = function(method, f) {
			var original = eval("this." + method);

			this[method] = function() {
				this.rv[method] = original.apply(this, arguments);

				return f.apply(this, arguments);
			};
		};

		object.around = function(method, f) {
			var original = eval("this." + method);

			this[method] = function() {
				this.yield = original;

				return f.apply(this, arguments);
			};
		};
	},

	addEventHandler: function(obj, type, func) {
		if (type.indexOf("on") != 0) {
			type = "on" + type;
		}

		var temp = obj[type];

		if (typeof obj[type] != "function") {
			obj[type] = func;
		}
		else {
			obj[type] = function() {
				if (temp) {
					temp();
				}

				func();
			}
		}
	},

	addInputFocus: function(el) {
		var item = null;

		if (el) {
			if (typeof el == 'object') {
				item = jQuery(el);
			}
			else {
				item = jQuery('#' + el);
			}
		}
		else {
			item = document.body;
		}

		var inputs = jQuery("input[type=text], input[type=password], textarea", item);

		inputs.focus(
			function() {
				jQuery(this).addClass('focus');

				if (this.createTextRange) {
					var value = this.value;
					var textRange = this.createTextRange();

					textRange.moveStart('character', value.length);
					textRange.select();
				}
			}
		);

		inputs.blur(
			function() {
				jQuery(this).removeClass('focus');
			}
		);
	},

	addInputType: function(el) {
		var item;

		if (jQuery.browser.msie && jQuery.browser.version.number() < 7) {
			if (el) {
				if (typeof el == 'object') {
					item = jQuery(el);
				}
				else {
					item = jQuery('#' + el);
				}
			}
			else {
				item = document.body;
			}

			_$J("input", item).each(function() {
				var current = _$J(this);
				var type = this.type || "text";

				current.addClass(type);
			});
		}
	},

	changeOpacity: function(object, opacity) {
		opacity = (opacity >= 1) ? 0.999 : opacity;
		opacity = (opacity < 0) ? 0 : opacity;

		object.style.opacity = opacity;
		object.style.MozOpacity = opacity;
		object.style.KhtmlOpacity = opacity;
		object.style.filter = "alpha(opacity=" + (opacity * 100) + ")";
	},

	check: function(form, name, checked) {
		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.name == name) && (e.type == "checkbox")) {
				e.checked = checked;
			}
		}
	},

	checkAll: function(form, name, allBox) {
		if (Liferay.Util.isArray(name)) {
			for (var i = 0; i < form.elements.length; i++) {
				var e = form.elements[i];

				if (e.type == "checkbox") {
					for (var j = 0; j < name.length; j++) {
						if (e.name == name[j]) {
							e.checked = allBox.checked;
						}
					}
				}
			}
		}
		else {
			for (var i = 0; i < form.elements.length; i++) {
				var e = form.elements[i];

				if ((e.name == name) && (e.type == "checkbox")) {
					e.checked = allBox.checked;
				}
			}
		}
	},

	checkAllBox: function(form, name, allBox) {
		var totalBoxes = 0;
		var totalOn = 0;

		if (Liferay.Util.isArray(name)) {
			for (var i = 0; i < form.elements.length; i++) {
				var e = form.elements[i];

				if ((e.name != allBox.name) && (e.type == "checkbox")) {
					for (var j = 0; j < name.length; j++) {
						if (e.name == name[j]) {
							totalBoxes++;

							if (e.checked) {
								totalOn++;
							}
						}
					}
				}
			}
		}
		else {
			for (var i = 0; i < form.elements.length; i++) {
				var e = form.elements[i];

				if ((e.name != allBox.name) && (e.name == name) && (e.type == "checkbox")) {
					totalBoxes++;

					if (e.checked) {
						totalOn++;
					}
				}
			}
		}

		if (totalBoxes == totalOn) {
			allBox.checked = true;
		}
		else {
			allBox.checked = false;
		}
	},

	checkMaxLength: function(box, maxLength) {
		if ((box.value.length) >= maxLength) {
			box.value = box.value.substring(0, maxLength - 1);
		}
	},

	checkTab: function(box) {
		if ((document.all) && (event.keyCode == 9)) {
			box.selection = document.selection.createRange();
			setTimeout("Liferay.Util.processTab(\"" + box.id + "\")", 0);
		}
	},

	createInputElement: function(name) {
		if (Liferay.Browser.is_ie) {
			var entry = document.createElement("<input name='" + name + "'></input>");
		}
		else {
			var entry = document.createElement("input");
			entry.name = name;
		}

		return entry;
	},

	disableEsc: function() {
		if ((document.all) && (event.keyCode == 27)) {
			event.returnValue = false;
		}
	},

	focusFormField: function(el) {
		jQuery(
			function() {
				if (el && (el.offsetHeight != 0)) {
					var elObj = jQuery(el);

					jQuery('input').trigger('blur');

					elObj.trigger('focus');
				}
			}
		);
	},

	getSelectedIndex: function(col) {
		for (var i = 0; i < col.length; i++) {
			if (col[i].checked == true) {
				return i;
			}
		}

		return -1;
	},

	getSelectedRadioValue: function(col) {
		var i = Liferay.Util.getSelectedIndex(col);

		if (i == -1) {
			var radioValue = col.value;

			if (radioValue == null) {
				radioValue = "";
			}

			return radioValue;
		}
		else {
			return col[i].value;
		}
	},

	isArray: function(object) {
		if (!window.Array) {
			return false;
		}
		else {
			return object.constructor == window.Array;
		}
	},

	listChecked: function(form) {
		var s = "";

		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.type == "checkbox") && (e.checked == true) && (e.value > "")) {
				s += e.value + ",";
			}
		}

		return s;
	},

	listCheckedExcept: function(form, except) {
		var s = "";

		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.type == "checkbox") && (e.checked == true) && (e.value > "") && (e.name.indexOf(except) != 0)) {
				s += e.value + ",";
			}
		}

		return s;
	},

	listSelect: function(box, delimeter) {
		var s = "";

		if (delimeter == null) {
			delimeter = ",";
		}

		if (box == null) {
			return "";
		}

		for (var i = 0; i < box.length; i++) {
			if (box.options[i].value > "") {
				s += box.options[i].value + delimeter;
			}
		}

		if (s == ".none,") {
			return "";
		}
		else {
			return s;
		}
	},

	listUncheckedExcept: function(form, except) {
		var s = "";

		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.type == "checkbox") && (e.checked == false) && (e.value > "") && (e.name.indexOf(except) != 0)) {
				s += e.value + ",";
			}
		}

		return s;
	},

	moveItem: function(fromBox, toBox, sort) {
		var newText = null;
		var newValue = null;
		var newOption = null;

		if (fromBox.selectedIndex >= 0) {
			for (var i = 0; i < fromBox.length; i++) {
				if (fromBox.options[i].selected) {
					newText = fromBox.options[i].text;
					newValue = fromBox.options[i].value;

					newOption = new Option(newText, newValue);

					toBox[toBox.length] = newOption;
				}
			}

			for (var i = 0; i < toBox.length; i++) {
				for (var j = 0; j < fromBox.length; j++) {
					if (fromBox[j].value == toBox[i].value) {
						fromBox[j] = null;

						break;
					}
				}
			}
		}

		if (newText != null) {
			if (sort == true) {
				Liferay.Util.sortBox(toBox);
			}
		}
	},

	portletTitleEdit: function(options) {
		var instance = this;

		var obj = options.obj;
		var plid = options.plid;
		var doAsUserId = options.doAsUserId;
		var portletId = options.portletId;
		var url = options.url;

		var title = obj.find('.portlet-title');

		if (!title.is('.not-editable')) {
			title.editable(
				function(value, settings) {
					var cruft = settings._LFR_.cruft || [];

					cruft = cruft.join('');

					if (value != settings._LFR_.oldText) {
						Liferay.Util.savePortletTitle(
							{
								plid: plid,
								doAsUserId: doAsUserId,
								portletId: portletId,
								title: value
							}
						);
					}

					obj[0]._LFR_noDrag = null;

					return cruft + value;
				},
				{
					cssclass: 'text',
					data: function(value, settings) {
						var input = jQuery(this);
						var re = new RegExp('<\/?[^>]+>|\n|\r|\t', 'gim');

						cruft = value.match(re);

						settings._LFR_ = {};
						settings._LFR_.oldText = value;
						settings._LFR_.cruft = cruft;

						value = value.replace(re, '');
						settings._LFR_.oldText = value;
						obj[0]._LFR_noDrag = true;

						return value;
					},
					height: '',
					width: '',
					onblur: 'submit',
					type: 'text',
					select: false,
					style: '',
					submit: ''
				}
			);
		}
	},

	processTab: function(id) {
		document.all[id].selection.text = String.fromCharCode(9);
		document.all[id].focus();
	},

	randomMinMax: function(min, max) {
		return (Math.round(Math.random() * (max - min))) + min;
	},

	removeItem: function(box, value) {
		if (value == null) {
			for (var i = box.length - 1; i >= 0; i--) {
				if (box.options[i].selected) {
					box[i] = null;
				}
			}
		}
		else {
			for (var i = box.length - 1; i >= 0; i--) {
				if (box.options[i].value == value) {
					box[i] = null;
				}
			}
		}
	},

	reorder: function(box, down) {
		var si = box.selectedIndex;

		if (si == -1) {
			box.selectedIndex = 0;
		}
		else {
			sText = box.options[si].text;
			sValue = box.options[si].value;

			if ((box.options[si].value > "") && (si > 0) && (down == 0)) {
				box.options[si].text = box.options[si - 1].text;
				box.options[si].value = box.options[si - 1].value;
				box.options[si - 1].text = sText;
				box.options[si - 1].value = sValue;
				box.selectedIndex--;
			}
			else if ((si < box.length - 1) && (box.options[si + 1].value > "") && (down == 1)) {
				box.options[si].text = box.options[si + 1].text;
				box.options[si].value = box.options[si + 1].value;
				box.options[si + 1].text = sText;
				box.options[si + 1].value = sValue;
				box.selectedIndex++;
			}
			else if (si == 0) {
				for (var i = 0; i < (box.length - 1); i++) {
					box.options[i].text = box.options[i + 1].text;
					box.options[i].value = box.options[i + 1].value;
				}

				box.options[box.length - 1].text = sText;
				box.options[box.length - 1].value = sValue;

				box.selectedIndex = box.length - 1;
			}
			else if (si == (box.length - 1)) {
				for (var j = (box.length - 1); j > 0; j--) {
					box.options[j].text = box.options[j - 1].text;
					box.options[j].value = box.options[j - 1].value;
				}

				box.options[0].text = sText;
				box.options[0].value = sValue;

				box.selectedIndex = 0;
			}
		}
	},

	resizeTextarea: function(elString) {
		var init = function() {
			var el = jQuery('#' + elString);

			if (el.length) {
				var pageBody = jQuery('body');

				var resize = function() {
					var pageBodyHeight = pageBody.height();

					el.css(
						{
							height: (pageBodyHeight - 100) + "px",
							width: '98%'
						}
					);
				};

				resize();

				jQuery(window).resize(resize);
			}
		};

		jQuery(init);
	},

	resubmitCountdown: function(formName) {
		if (Liferay.Util.submitCountdown > 0) {
			Liferay.Util.submitCountdown--;

			setTimeout("Liferay.Util.resubmitCountdown('" + formName + "')", 1000);
		}
		else {
			Liferay.Util.submitCountdown = 0;

			if (!Liferay.Browser.is_ns_4) {
				document.body.style.cursor = "auto";
			}

			var form = document.forms[formName];

			for (var i = 0; i < form.length; i++){
				var e = form.elements[i];

				if (e.type && (e.type.toLowerCase() == "button" || e.type.toLowerCase() == "reset" || e.type.toLowerCase() == "submit")) {
					e.disabled = false;
				}
			}
		}
	},

	savePortletTitle: function(params) {
		var defaultParams = {
			plid: 0,
			doAsUserId: 0,
			portletId: 0,
			title: '',
			url: themeDisplay.getPathMain() + '/portlet_configuration/update_title'
		};

		var settings = jQuery.extend(defaultParams, params);

		jQuery.ajax(
			{
				url: settings.url,
				data: {
					p_l_id: settings.plid,
					doAsUserId: settings.doAsUserId,
					portletId: settings.portletId,
					title: settings.title
				}
			}
		);
	},

	selectAndCopy: function(el) {
		el.focus();
		el.select();

		if (document.all) {
			var textRange = el.createTextRange();

			textRange.execCommand("copy");
		}
	},

	setBox: function(oldBox, newBox) {
		for (var i = oldBox.length - 1; i > -1; i--) {
			oldBox.options[i] = null;
		}

		for (var i = 0; i < newBox.length; i++) {
			oldBox.options[i] = new Option(newBox[i].value, i);
		}

		oldBox.options[0].selected = true;
	},

	setSelectedValue: function(col, value) {
		for (var i = 0; i < col.length; i++) {
			if ((col[i].value != "") && (col[i].value == value)) {
				col.selectedIndex = i;

				break;
			}
		}
	},

	setSelectVisibility: function(mode, obj) {
		if (Liferay.Browser.is_ie) {
			if (obj) {
				obj = jQuery.getOne(obj);
			}
			else {
				obj = document.getElementsByTagName("body")[0];
			}

			selectList = obj.getElementsByTagName("select");
			for (var i = 0; i < selectList.length; i++) {
				selectList[i].style.visibility = mode;
			}
		}
	},

	slideMaximize: function(id, height, speed) {
		var obj = document.getElementById(id);
		var reference = obj.getElementsByTagName("DIV")[0];

		height += speed;

		if (height < (reference.offsetHeight)) {
			obj.style.height = height + "px";

			setTimeout("Liferay.Util.slideMaximize(\"" + id + "\"," + height + "," + speed + ")", 10);
		}
		else {
			obj.style.overflow = "";
			obj.style.height = "";
		}
	},

	slideMinimize: function(id, height, speed) {
		var obj = document.getElementById(id);

		height -= speed;

		if (height > 0) {
			obj.style.height = height + "px";
			setTimeout("Liferay.Util.slideMinimize(\"" + id + "\"," + height + "," + speed + ")", 10);
		}
		else {
			obj.style.height = "1px";
		}
	},

	sortBox: function(box) {
		var newBox = [];

		for (var i = 0; i < box.length; i++) {
			newBox[i] = [box[i].value, box[i].text];
		}

		newBox.sort(Liferay.Util.sortByAscending);

		for (var i = box.length - 1; i > -1; i--) {
			box.options[i] = null;
		}

		for (var i = 0; i < newBox.length; i++) {
			box.options[box.length] = new Option(newBox[i][1], newBox[i][0]);
		}
	},

	sortByAscending: function(a, b) {
		if (a[1].toLowerCase() > b[1].toLowerCase()) {
			return 1;
		}
		else if (a[1].toLowerCase() < b[1].toLowerCase()) {
			return -1;
		}
		else {
			return 0;
		}
	},

	toggleByIdSpan: function(obj, id) {
		var hidden = Liferay.Util.toggle(id, true);
		var spanText = obj.getElementsByTagName("span");

		if (hidden) {
			spanText[0].style.display = "none";
			spanText[1].style.display = "";
		}
		else {
			spanText[0].style.display = "";
			spanText[1].style.display = "none";
		}
	},

	toggle: function(obj, returnState, displayType) {
		var hidden = false;
		var display = "";
		obj = _$J.getOne(obj);

		if (displayType != null) {
			display = displayType;
		}

		if (obj != null) {
			if (!obj.style.display || !obj.style.display.toLowerCase().match("none")) {
				obj.style.display = "none";
			}
			else {
				obj.style.display = display;
				hidden = true;
			}
		}

		if (returnState) {
			return hidden;
		}
	},

	toggleBoxes: function(checkBoxId, toggleBoxId) {
		var checkBox = jQuery('#' + checkBoxId);
		var toggleBox = jQuery('#' + toggleBoxId);

		if (!checkBox.is(':checked')){
			toggleBox.hide();
		}

		checkBox.click(
			function(){
				toggleBox.toggle();
			}
		);
	},

	toJSONObject: function(s) {
		try {
			return eval("(" + s + ")");
		}
		catch (e) {
			return {};
		}
	},

	toJSONString: function (s) {
		var rt = s;
		var m = {
			'\b': '\\b',
			'\t': '\\t',
			'\n': '\\n',
			'\f': '\\f',
			'\r': '\\r',
			'"' : '\\"',
			'\\': '\\\\'
		};

		if (/["\\\x00-\x1f]/.test(s)) {
			rt = s.replace(/([\x00-\x1f\\"])/g, function(a, b) {
				var c = m[b];
				if (c) {
					return c;
				}
				c = b.charCodeAt();
				return '\\u00' +
					Math.floor(c / 16).toString(16) +
					(c % 16).toString(16);
			});
		}

		return rt;
	}
};

function cloneObject (obj, recurse) {
	for (i in obj) {
		if (typeof obj[i] == 'object' && recurse) {
			this[i] = new cloneObject(obj[i], true);
		}
		else
			this[i] = obj[i];
	}
}

Element = {};

Element.disable = function(element) {
	element = _$J.getOne(element);

	var items = element.getElementsByTagName("*");

	for (var i = 0; i < items.length; i++) {
		var item = items[i];
		var nodeName = item.nodeName.toLowerCase();

		item.onclick = function() {};
		item.onmouseover = function() {};
		item.onmouseout = function() {};

		if (Liferay.Browser.is_ie) {
			item.onmouseenter = function() {};
			item.onmouseleave = function() {};
		}

		if (nodeName == "a") {
			item.href = "javascript: void(0)";
		}
		else if (nodeName == "input" || nodeName == "select" || nodeName == "script") {
			item.disabled = "true";
		}
		else if (nodeName == "form") {
			item.action = "";
			item.onsubmit = function() { return false; };
		}

		item.style.cursor = "default";
	}
};

Element.remove = function(id) {
	var obj = jQuery.getOne(id);

	obj.parentNode.removeChild(obj);
};

function LinkedList() {
	this.head = null;
	this.tail = null;
}

LinkedList.prototype.add = function(obj) {
	obj.listInfo = {};
	var tail = this.tail;
	var head = this.head;

	if (this.head == null) {
		this.head = obj;
		this.tail = obj;
	}
	else {
		this.tail.listInfo.next = obj;
		obj.listInfo.prev = this.tail;
		this.tail = obj;
	}

	obj.listInfo.listObj = this;
};

LinkedList.prototype.remove = function(obj) {
	if (obj.listInfo.listObj == this && this.head) {
		var next = obj.listInfo.next;
		var prev = obj.listInfo.prev;

		if (next) {
			next.listInfo.prev = prev;
		}
		if (prev) {
			prev.listInfo.next = next;
		}
		if (this.head == obj) {
			this.head = next;
		}
		if (this.tail == obj) {
			this.tail = prev;
		}
	}
};

LinkedList.prototype.each = function(func) {
	var cur = this.head;
	var count = 0;

	while (cur){
		count++;
		var next = cur.listInfo.next;

		if (func) {
			func(cur);
		}

		cur = next;
	}

	return count;
};

LinkedList.prototype.size = function() {
	return this.each();
};

// String functions

function startsWith(str, x) {
	if (str.indexOf(x) == 0) {
		return true;
	}
	else {
		return false;
	}
}

function endsWith(str, x) {
	if (str.lastIndexOf(x) == str.length - x.length) {
		return true;
	}
	else {
		return false;
	}
}

// Netscape 4 functions

if (Liferay.Browser.is_ns_4) {
	encodeURIComponent = new function(uri) {
		return escape(uri);
	};

	decodeURIComponent = new function(uri) {
		return unescape(uri);
	};
}

function submitForm(form, action, singleSubmit) {
	if (Liferay.Util.submitCountdown == 0) {
		Liferay.Util.submitCountdown = 10;

		setTimeout("Liferay.Util.resubmitCountdown('" + form.name + "')", 1000);

		if (singleSubmit == null || singleSubmit) {
			Liferay.Util.submitCountdown++;

			var inputs = jQuery('input[type=button], input[type=reset], input[type=submit]', form);

			inputs.each(
				function(i, el) {
					var input = jQuery(this);

					input.attr('disabled', true);
					input.fadeTo(50, 0.5);
				}
			);
		}

		if (action != null) {
			form.action = action;
		}

		if (!Liferay.Browser.is_ns_4) {
			document.body.style.cursor = "wait";
		}

		form.submit();
	}
	else {
		if (Liferay.Util.submitFormAlert != null) {
			submitFormAlert(Liferay.Util.submitCountdown);
		}
	}
}

var Viewport = {
	frame: function() {
		var x,y;
		if (self.innerHeight) // all except Explorer
		{
			x = self.innerWidth;
			y = self.innerHeight;
		}
		else if (document.documentElement && document.documentElement.clientHeight)
			// Explorer 6 Strict Mode
		{
			x = document.documentElement.clientWidth;
			y = document.documentElement.clientHeight;
		}
		else if (document.body) // other Explorers
		{
			x = document.body.clientWidth;
			y = document.body.clientHeight;
		}

		return (new Coordinate(x,y));
	},

	scroll: function() {
		var x,y;
		if (self.pageYOffset) {
			// all except Explorer
			x = self.pageXOffset;
			y = self.pageYOffset;
		}
		else if (document.documentElement && document.documentElement.scrollTop) {
			// Explorer 6 Strict
			x = document.documentElement.scrollLeft;
			y = document.documentElement.scrollTop;
		}
		else if (document.body) {
			// all other Explorers
			x = document.body.scrollLeft;
			y = document.body.scrollTop;
		}

		return (new Coordinate(x,y));
	},

	page: function() {
		var x,y;
		var test1 = document.body.scrollHeight;
		var test2 = document.body.offsetHeight;
		if (test1 > test2) // all but Explorer Mac
		{
			x = document.body.scrollWidth;
			y = document.body.scrollHeight;
		}
		else // Explorer Mac;
			//would also work in Explorer 6 Strict, Mozilla and Safari
		{
			x = document.body.offsetWidth;
			y = document.body.offsetHeight;
		}

		return (new Coordinate(x,y));
	}
};

String.prototype.trim = jQuery.trim;

// 0-200: Theme Developer
// 200-400: Portlet Developer
// 400+: Liferay

Liferay.zIndex = {
	DOCK:			10,
	DOCK_PARENT:	20,
	ALERT:			430,
	DROP_AREA:		440,
	DROP_POSITION:	450,
	DRAG_ITEM:		460
};
// file seperator

Liferay.Language = {
	get: function(key, extraParams) {
		var instance = this;

		var url = themeDisplay.getPathContext() + '/language/' + themeDisplay.getLanguageId() + '/' + key + '/';

		if (extraParams) {
			if (typeof extraParams == 'string') {
				url += extraParams;
			}
			else if (Liferay.Util.isArray(extraParams)) {
				url += extraParams.join('/');
			}
		}

		var value = instance._cache[url];

		if (value != null) {
			return value;
		}

		var xHR = jQuery.ajax(
			{
				url: url,
				async: false
			}
		);

		value = xHR.responseText;

		instance._cache[url] = value;

		return value;
	},

	_cache: {}
};
// file seperator

Liferay.Layout = {
	getGroupId: function(objId) {
		var instance = this;

		if ((objId != null) &&
			(objId.indexOf(instance._private) == 0 || objId.indexOf(instance._public) == 0)) {

			return objId.split(instance._separator)[1];
		}

		return 0;
	},

	getLayoutId: function(objId) {
		var instance = this;

		if ((objId != null) &&
			(objId.indexOf(instance._private) == 0 || objId.indexOf(instance._public) == 0)) {

			return objId.split(instance._separator)[2];
		}

		return 0;
	},

	getOwnerId: function(objId) {
		var instance = this;

		if ((objId != null) &&
			(objId.indexOf(instance._private) == 0 || objId.indexOf(instance._public) == 0)) {

			var pos = objId.lastIndexOf(instance._separator);

			if (pos != -1) {
				return objId.substring(0, pos);
			}

			return null;
		}
	},

	_private: 'PRI.',
	_public: 'PUB.',
	_separator: '.'
};
// file seperator

function AjaxRequest(url, options) {

	var xmlHttpReq;
	var opts = options;

	if (window.XMLHttpRequest) {
		xmlHttpReq = new XMLHttpRequest();

		if (xmlHttpReq.overrideMimeType) {
			xmlHttpReq.overrideMimeType("text/html");
		}
	}
	else if (window.ActiveXObject) {
		try {
			xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			try {
				xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				try {
					xmlHttpReq = new XMLHttpRequest();
				}
				catch (e) {
				}
			}
		}
	}

	var returnFunction = function() {
			if (xmlHttpReq.readyState == 4) {
				try {
					if (xmlHttpReq.status == 200) {
						if (opts.update) {
							var el = jQuery.getOne(opts.update);
							el.innerHTML = xmlHttpReq.responseText;
							executeLoadedScript(el);
						}

						if (opts.onComplete) {
							opts.onComplete(xmlHttpReq, opts.returnArgs);
						}

						AjaxUtil.remove(opts.ajaxId);
					}
				}
				catch(e) {
				}
			}
		};

	var send = function(url) {
		var urlArray = url.split("?");
		var path = urlArray[0];
		var query = urlArray[1];

		try {
			if (opts.method == "get") {
				xmlHttpReq.open("GET", url, true);
				xmlHttpReq.onreadystatechange = returnFunction;
				xmlHttpReq.send("");
			}
			else {
				xmlHttpReq.open("POST", path, true);
				xmlHttpReq.setRequestHeader("Method", "POST " + path + " HTTP/1.1");
				xmlHttpReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xmlHttpReq.onreadystatechange = returnFunction;
				xmlHttpReq.send(query);
			}
		}
		catch (e) {
		}
	};

	send(url);

	this.resend = function(url, options) {
		opts = options;
		/*
		ajaxId = 0;
		onComplete = opts.onComplete;
		*/
		send(url);
	};

	this.getId = function() {
		return ajaxId;
	};

	this.cleanUp = function() {
		xmlHttpReq.onreadystatechange = function() {};
		returnFunction = null;
		returnArgs = null;
		xmlHttpReq = null;
	};
}

var AjaxUtil = {
	counter : 1,
	requests : [],

	request : function(url, options) {
		/*
		 * OPTIONS:
		 * onComplete (function) - function to call after response is received
		 * returnArgs (object) - object to pass to return function
		 * reverseAjax (boolean) - use reverse ajax. (only one at a time)
		 * method (string) - use "get" or "post". Default is post.
		 */
		var opts = options || {};
		var ajaxId = (opts.reverseAjax) ? 0 : AjaxUtil.getNextId();
		opts.ajaxId = ajaxId;

		var request;

		if (ajaxId == 0 && AjaxUtil.requests[0]) {
			request = AjaxUtil.requests[0];
			request.resend(url, opts);
		}
		else {
			request = new AjaxRequest(url, opts);
			AjaxUtil.requests[ajaxId] = request;
		}

		if (!opts.onComplete && !opts.update) {
			AjaxUtil.remove(ajaxId);
		}
	},

submit: function(form, id, options) {
var url = form.action;
var opts = options || {};
var inputs = jQuery("input, textarea, select", form);
for( var i = 0 ; i < inputs.length ; i++ ) {
if( (inputs[i].disabled) ||
((inputs[i].type == "radio" || inputs[i].type == "checkbox") && !inputs[i].checked) ) {
delete inputs[i];
}
}

var params = inputs.serialize().replace(/=undefined&/g, "");

if (url.indexOf("?") == -1) {
url = url + "?" + params;
}

if (url.lastIndexOf("?") == url.length - 1 || url.lastIndexOf("&") == url.length - 1) {
url = url + params;
}
else {
url = url + "&" + params;
}

if (opts.disable) {
inputs.attr("disabled", true);
}

AjaxUtil.update(url, id, opts);
},


	submit_old: function(form, options) {
		var url = form.action;
		var inputs = jQuery("input, textarea, select", form);
		var opts = options || {};
		var params = inputs.serialize();

		if (url.indexOf("?") == -1) {
			url = url + "?" + params;
		}
		if (url.lastIndexOf("?") == url.length - 1) {
			url = url + params;
		}
		else {
			url = url + "&" + params;
		}

		if (opts.disable) {
			inputs.attr("disabled", true);
		}

		AjaxUtil.request(url, opts);
	},

	update : function(url, id, options) {
		var opts = options || {};
		opts.update = id;
		AjaxUtil.request(url, opts);
	},


	update2 : function(url, id) {
		var opts = {};
		opts.update = id;
		opts.onComplete = function(){hideLoading()};
		showLoading();
		AjaxUtil.request(url, opts);
	},

	getNextId : function() {
		var id = AjaxUtil.counter++;

		if (AjaxUtil.counter > 20) {
			/* Reset array in a round-robin fashion */
			/* Reserve index 0 for reverse ajax requests */
			AjaxUtil.counter = 1;
		}

		return id;
	},

	remove : function(id) {
		if (id) {
			var request = AjaxUtil.requests[id];

			if (request) {
				request.cleanUp();
				request = null;
			}
		}
	}
};

var ReverseAjax = {
	initialize: function() {
		Liferay.Util.addEventHandler(window, "unload", ReverseAjax.release);
		ReverseAjax.request();
	},

	request: function() {
		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/reverse_ajax",
			{
				onComplete: ReverseAjax.response,
				reverseAjax: true
			});
	},

	response: function(xmlHttpRequest) {
		var res = Liferay.Util.toJSONObject(xmlHttpRequest.responseText);
		var status = res.status;

		if (status && status != "failure") {
			if (status == "success") {
				if (res.chatMessages) {
					Messaging.getChatsReturn(res.chatMessages);
				}
				if (res.chatRoster) {
					MessagingRoster.getEntriesReturn(res.chatRoster);
				}
			}

			ReverseAjax.request();
		}
	},

	release : function() {
		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/reverse_ajax?release=1", {reverseAjax:true});
	}
};

function executeLoadedScript(el) {
	var scripts = el.getElementsByTagName("script");

	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			try {
				if (Liferay.Browser.is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (Liferay.Browser.is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					eval(scripts[i].text);
				}
			}
			catch (e) {}
		}
	}
}

/*
 * NOTE: loadPage() has been depricated.  Use AjaxUtil.request() instead
 */
function loadPage(path, queryString, returnFunction, returnArgs) {
	AjaxUtil.request(path + "?" + queryString, {
			onComplete: returnFunction,
			returnArgs: returnArgs
		});
}

function printJSON(data) {
	if (data && data.id) {
		var target = document.getElementById(data.id);

		if (target) {
			target.innerHTML = data.toString();
		}
	}
}

function showLoading() {

    var div = document.getElementById("AA_" + this.id + "_loading_div");
    if (div == null) {
        div = document.createElement("DIV");

        document.body.appendChild(div);
        div.id = "AA_" + this.id + "_loading_div";

        div.innerHTML = "&nbsp;Loading...";
        div.style.position = "absolute";
        div.style.border = "1 solid black";
        div.style.color = "white";
        div.style.backgroundColor = "blue";
        div.style.width = "100px";
        div.style.heigth = "50px";
        div.style.fontFamily = "Arial, Helvetica, sans-serif";
        div.style.fontWeight = "bold";
        div.style.fontSize = "11px";
    }
    div.style.top = document.body.scrollTop + "px";
    div.style.left = (document.body.offsetWidth - 100 - (document.all?20:0)) + "px";

    div.style.display = "";
}

/**
*  Default sample loading message hide function. Overrride it if you like.
*/
function hideLoading() {

    var div = document.getElementById("AA_" + this.id + "_loading_div");
    if (div != null)
        div.style.display = "none";

}
// file seperator

Liferay.Animate = function(id, fn, data) {

	/* id - unique identifier for this process
	 * fn - animation function
	 * data - object that is passed to the animation function
	 * data.delay - assign a number (in milliseconds) to this property
	 *				to delay the start of the animation process
	 */
	var lib = Liferay.Animate;

	if (!lib.q[id]) {
		lib.q[id] = {"id": id, "fn": fn, "data": data};
	}

	if (!lib.timer) {
		lib.start();
	}
};

Liferay.Animate.extendNativeFunctionObject({
	q: {},
	timer: 0,

	process: function() {
		var processed = false;
		for (var i in this.q) {
			var item = this.q[i];
			if (item) {
				var rt = item.fn(item.data);

				if (rt == false) {
					this.q[i] = null;
				}
				processed = true;
			}
		}

		if (!processed) {
			this.stop();
		}
	},

	start: function() {
		var lib = Liferay.Animate;
		if (!lib.timer) {
			Liferay.Animate.process();
			Liferay.Animate.timer = setInterval("Liferay.Animate.process()", 30);
		}
	},

	stop: function() {
		clearInterval(Liferay.Animate.timer);
		Liferay.Animate.timer = 0;
	}
});
// file seperator

/**********************************************************
 Very minorly modified from the example by Tim Taylor
 http://tool-man.org/examples/sorting.html

 Added Coordinate.prototype.inside( northwest, southeast );

 **********************************************************/


var Coordinates = {
	ORIGIN : new Coordinate(0, 0),

	coordinatesData: function(element, recurse) {
		var data = {};

		data.recurse = recurse;
		data.size = new Coordinate(element.offsetWidth, element.offsetHeight);
		data.nwOffset = Coordinates.northwestOffset(element, recurse);
		data.seOffset = data.nwOffset.plus(data.size);
		data.midPoint = data.nwOffset.plus(new Coordinate(Math.round(data.size.x/2), Math.round(data.size.y/2)));

		return data;
	},

	northwestPosition : function(element) {
		var x = parseInt(element.style.left);
		var y = parseInt(element.style.top);

		return new Coordinate(isNaN(x) ? 0 : x, isNaN(y) ? 0 : y);
	},

	southeastPosition : function(element) {
		return Coordinates.northwestPosition(element).plus(
				new Coordinate(element.offsetWidth, element.offsetHeight));
	},

	northwestOffset : function(element, isRecursive) {
		var offset = new Coordinate(element.offsetLeft, element.offsetTop);

		if (!isRecursive) return offset;

		var parent = element.offsetParent;
		while (parent) {
			offset = offset.plus(
					new Coordinate(parent.offsetLeft, parent.offsetTop));
			parent = parent.offsetParent;
		}
		return offset;
	},

	southeastOffset : function(element, isRecursive) {
		return Coordinates.northwestOffset(element, isRecursive).plus(
				new Coordinate(element.offsetWidth, element.offsetHeight));
	}
};

function Coordinate(x, y) {
	this.x = x || 0;
	this.y = y || 0;
}

Coordinate.prototype.toString = function() {
	return "(" + this.x + "," + this.y + ")";
};

Coordinate.prototype.plus = function(that) {
	return new Coordinate(this.x + that.x, this.y + that.y);
};

Coordinate.prototype.minus = function(that) {
	return new Coordinate(this.x - that.x, this.y - that.y);
};

Coordinate.prototype.distance = function(that) {
	var deltaX = this.x - that.x;
	var deltaY = this.y - that.y;

	return Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));
};

Coordinate.prototype.max = function(that) {
	var x = Math.max(this.x, that.x);
	var y = Math.max(this.y, that.y);
	return new Coordinate(x, y);
};

Coordinate.prototype.constrain = function(min, max) {
	if (min.x > max.x || min.y > max.y) return this;

	var x = this.x;
	var y = this.y;

	if (min.x != null) x = Math.max(x, min.x);
	if (max.x != null) x = Math.min(x, max.x);
	if (min.y != null) y = Math.max(y, min.y);
	if (max.y != null) y = Math.min(y, max.y);

	return new Coordinate(x, y);
};

Coordinate.prototype.reposition = function(element) {
	element.style["top"] = this.y + "px";
	element.style["left"] = this.x + "px";
};

Coordinate.prototype.equals = function(that) {
	if (this == that) return true;
	if (!that || that == null) return false;

	return this.x == that.x && this.y == that.y;
};

// returns true of this point is inside specified box
Coordinate.prototype.inside = function(northwest, southeast) {
	if ((this.x >= northwest.x) && (this.x <= southeast.x) &&
		(this.y >= northwest.y) && (this.y <= southeast.y)) {

		return true;
	}
	else {
		return false;
	}
};

Coordinate.prototype.insideObject = function(obj, recurse) {
	var data = Coordinates.coordinatesData(obj);
	data.recurse = recurse;
	data.quadrant = this.insideObjectData(data);

	return data.quadrant ? data : null;
};

Coordinate.prototype.insideObjectData = function(data) {
	var nwOffset = data.nwOffset;
	var seOffset = data.seOffset;
	var rt = 0;

	if (this.inside(nwOffset, seOffset)) {
		var mid = data.midPoint;

		if (this.x <= mid.x && this.y <= mid.y) {
			rt = 1;
		}
		else if (this.x >= mid.x && this.y <= mid.y) {
			rt = 2;
		}
		else if (this.x >= mid.x && this.y >= mid.y) {
			rt = 3;
		}
		else if (this.x <= mid.x && this.y >= mid.y) {
			rt = 4;
		}
	}

	return rt;
};

function MousePos () { };

// Extend the "Coordinate" class
MousePos.prototype = new Coordinate();

MousePos.prototype.update = function(event) {

	if (typeof event == 'undefined') {
		event = window.event;
	}

	var position = new Coordinate(event.clientX, event.clientY);

	var scrollOffset = Viewport.scroll();

	this.x = position.x + scrollOffset.x;
	this.y = position.y + scrollOffset.y;

	if (this.x < 0) this.x = 0;

	if (this.y < 0) this.y = 0;

	return event;
};

// Track mouse's absolute position (counting scrollbars)
var mousePos = new MousePos(0,0);

/*
 * jQuery extension
 */
jQuery.each([
				"coordinatesData",
				"northwestPosition",
				"southeastPosition",
				"northwestOffset",
				"southeastOffset"
			], function(i,n){

	jQuery.fn[ n ] = function(h) {
		return this.length > 0 ? Coordinates[n](this[0], h) : null;
	};
});

jQuery.fn.xySize = function() {
	return new Coordinate(this.width(), this.height());
};
// file seperator

(function($){

	$.fn.lDrag = function(options) {
		this.each(function() {
			$.lDrag.create(this, options)
		});
	};

	$.fn.lDragBind = function(type, fn) {
		this.each(function() {
			$.lDrag.bind(this, type, fn);
		});
	};

	$.fn.lDragUnbind = function(type, fn) {
		this.each(function() {
			$.lDrag.unbind(this, type, fn);
		});
	};


	/* Define lDrag */

	$.lDrag = function(container, options) {
		/* OPTIONS
		 * handle (object): drag handle
		 * onStart (function): excute at start
		 * onMove (function): execute during dragging
		 * onComplete (function):  execute when completed
		 */
		$.lDrag.create(container, options)
	};

	$.lDrag.extendNativeFunctionObject({
		container : null,
		isDragging : false,
		scrollDirection: "",
		scrollTimer: 0,

		bind: function(container, type, fn) {
			if (container.dragSettings && type && fn) {
				if (type == "start") {
					container.dragSettings.onDragStart.push(fn);
				}
				else if (type == "move") {
					container.dragSettings.onDrag.push(fn);
				}
				else if (type == "complete") {
					container.dragSettings.onDragEnd.push(fn);
				}
			}
		},

		unbind: function(container, type, fn) {
			if (container.dragSettings && type && fn) {
				var settings = container.dragSettings;
				var prop = "";

				if (type == "start") {
					prop = "onDragStart";
				}
				else if (type == "move") {
					prop = "onDrag";
				}
				else if (type == "complete") {
					prop = "onDragEnd";
				}

				for (var i = 0; i < settings[prop].length; i++) {
					if (settings[prop][i] == fn) {
						settings[prop].splice(i,1);
					}
				}
			}
		},

		create: function(container, options) {
			options = options || {};
			options.container = container;

		    if (options.handle == null) {
	    		options.handle = container;
    		}
    		else {
    			if (typeof options.handle == "string") {
    				options.handle = $(options.handle)[0];
    			}
				options.handle.dragSettings = options;
    		}
			container.dragSettings = options;

			options.onDragStart = [];
			options.onDrag = [];
			options.onDragEnd = [];

			// Bind event listeners
			if (options.onStart) {
				$.lDrag.bind(container, "start", options.onStart);
			}
			if (options.onMove) {
				$.lDrag.bind(container, "move", options.onMove);
			}
			if (options.onComplete) {
				$.lDrag.bind(container, "complete", options.onComplete);
			}

			jQuery(options.handle).mousedown($.lDrag.onMouseDown);
		},

		scroll: function() {
			Liferay.Animate("layoutDragScroll", $.lDrag.scrollStart);
		},

	    scrollStart: function() {
	        var nwPosition;
	        var container = $.lDrag.container;
	        var jContainer = $($.lDrag.container);
	        var setTimer = false;
	        var scrollSpeed = 20;
	        var scrollTop = Viewport.scroll().y;

	        if ($.lDrag.scrollDirection == "down") {
	            nwPosition = jContainer.northwestPosition();
	            nwPosition.y += scrollSpeed;
	            nwPosition.reposition(container);
	            window.scrollTo(0, scrollTop + scrollSpeed);
	            setTimer = true;
	        }
	        else if ($.lDrag.scrollDirection == "up" && scrollTop > 0) {
	            nwPosition = jContainer.northwestPosition();
	            nwPosition.y -= scrollSpeed;
	            nwPosition.reposition(container);
	            window.scrollTo(0, scrollTop - scrollSpeed);
	            setTimer = true;
	        }
	        else {
	            setTimer = false;
	        }

	        if (!setTimer) {
	            $.lDrag.scrollDirection = "";
	            $.lDrag.scrollTimer = 0;
	            return false;
	        }
	    },

		onMouseDown: function(event) {
			mousePos.update(event);

			var settings = this.dragSettings;
			var container = settings.container;
			var jContainer = $(settings.container);

			if (!container._LFR_noDrag) {
				$.lDrag.container = container;
	
				var nwOffset = jContainer.northwestOffset(true);
				var seOffset = nwOffset.plus(jContainer.xySize());
	
				settings.originalZIndex = container.style.zIndex;
	
				// Offset of the mouse relative to the dragging container
				// This should remain constant.
				settings.mouseNwOffset = mousePos.minus(nwOffset);
				settings.mouseSeOffset = mousePos.minus(seOffset);
				settings.mouseStart = new Coordinate(mousePos.x, mousePos.y);
	
				$.lDrag._processListeners(settings, "start");
	
				$.lDrag._setConstraint(settings);

				jQuery(document).mousemove($.lDrag.onMouseMove);
				jQuery(document).mouseup($.lDrag.onMouseUp);
			
				return false;
			}
			else {
				return;
			}
		},

		onMouseMove: function(event) {
			mousePos.update(event);
			// Assigning "container" because event is associated with the document
			// and not the dragging obj.  This is for robustness during a drag
			var container = $.lDrag.container;
			var settings = container.dragSettings;

			if (!$.lDrag._isAboveThreshold(settings)) {
				return false;
			}
			else {
				$.lDrag.isDragging = true;
			}

			container = settings.clone ? $.lDrag._createClone(settings) : settings.container;

			var jContainer = $(container);
			var nwOffset = jContainer.northwestOffset(true);
			var nwPosition = jContainer.northwestPosition();
			var size = jContainer.xySize();
			var seOffset = nwOffset.plus(size);
			var sePosition = nwPosition.plus(size);

			$.lDrag._setScrolling(settings);

			// new-pos = cur-pos + (mouse-pos - mouse-offset - screen-offset)
			//
			//	 new-pos: where we want to position the element using styles
			//	 cur-pos: current styled position of container
			//	 mouse-pos: mouse position
			//	 mouse-offset: mouse position relative to the dragging container
			//	 screen-offset: screen position of the current element
			//
			nwPosition = nwPosition.plus(mousePos.minus(nwOffset).minus(settings.mouseNwOffset));

			var offsetBefore = settings.autoCorrect ? jContainer.northwestOffset(true) : null;

			if (!settings.noDrag) {
				nwPosition.reposition(container);
			}

			$.lDrag._processListeners(settings, "move");

			// once dragging has started, the position of the container
			// relative to the mouse should stay fixed.  They can get out
			// of sync if the DOM is manipulated while dragging, so we
			// correct the error here
			//
			// changed to be recursive/use absolute offset for corrections


			if (settings.autoCorrect) {
				var offsetAfter = jContainer.northwestOffset(true);

				if (!offsetBefore.equals(offsetAfter)) {
					// Position of the container has changed after the onDrag call.
					// Move element to the current mouse position
					var errorDelta = offsetBefore.minus(offsetAfter);
					nwPosition = jContainer.northwestPosition().plus(errorDelta);
					nwPosition.reposition(container);
				}
			}

			return false;
		},

		onMouseUp: function(event) {
			event = mousePos.update(event);
			var container = $.lDrag.container;
			var settings = container.dragSettings;

			if (settings.clone) $.lDrag._destroyClone(settings);

			jQuery(document).unbind("mousemove", $.lDrag.onMouseMove);
			jQuery(document).unbind("mouseup", $.lDrag.onMouseUp);

			$.lDrag._processListeners(settings, "complete");
			$.lDrag.container = null;
			$.lDrag.isDragging = false;
		},

		_createClone: function(settings) {
			if (!settings.clonedNode) {
				var jClone = $("<div></div>");
				var jContainer = $(settings.container);
				var nwPosition = jContainer.northwestOffset(true);

				jClone.css({
					height: jContainer.height() + "px",
					left: nwPosition.x + "px",
					position: "absolute",
					top: nwPosition.y + "px",
					width: jContainer.width() + "px",
					zIndex: Liferay.zIndex.DRAG_ITEM
				});

				if (settings.opacity) jClone.css("opacity", settings.opacity);
				if (settings.dragClass) jClone.addClass(settings.dragClass);

				jClone[0].dragSettings = settings;
				settings.clonedNode = jClone[0];

				$("body").append(jClone);
			}

			return settings.clonedNode;
		},

		_destroyClone: function(settings) {
			if (settings.clonedNode) {
				var jClone = $(settings.clonedNode);
				var jContainer = $(settings.container);
				var containerPos = jContainer.northwestPosition();
				var newPos = containerPos.plus(mousePos.minus(settings.mouseStart));

				newPos.reposition(settings.container);

				jClone.remove();
				settings.clonedNode = null;
			}
		},

		_isAboveThreshold: function(settings) {
			var rt = true;
			if (!$.lDrag.isDragging && settings.threshold) {
				var distance = settings.mouseStart.distance(mousePos);
				if (distance < settings.threshold) {
					rt = false;
				}
			}

			return rt;
		},

		_processListeners: function(settings, type) {
			var prop = "";

			if (type == "start") {
				prop = "onDragStart";
			}
			else if (type == "move") {
				prop = "onDrag";
			}
			else if (type == "complete") {
				prop = "onDragEnd";
			}

			for (var i = 0; i < settings[prop].length; i++) {
				settings[prop][i](settings);
			}
		},

		_setConstraint: function(settings) {
			// Constraint coordinates are translated to mouse constraint coordinates.
			// The algorithm below will looks at the bounds of the dragging container and
			// makes sure that no part of it extends outside the constraint bounds.

			var minMouseX;
			var minMouseY;
			var maxMouseX;
			var maxMouseY;

			if (settings.minX != null)
				minMouseX = settings.minX + settings.mouseNwOffset.x;
			if (settings.minY != null)
				minMouseY = settings.minY + settings.mouseNwOffset.y;
			if (settings.maxX != null)
				maxMouseX = settings.maxX + settings.mouseSeOffset.x;
			if (settings.maxY != null)
				maxMouseY = settings.maxY + settings.mouseSeOffset.y;

			if (minMouseX && maxMouseX && minMouseX > maxMouseX)
				maxMouseX = minMouseX;
			if (minMouseY && maxMouseY && minMouseY > maxMouseY)
				maxMouseY = minMouseY;

			settings.mouseMin = new Coordinate(minMouseX, minMouseY);
			settings.mouseMax = new Coordinate(maxMouseX, maxMouseY);
		},

		_setScrolling: function(settings) {
			// Automatically scroll the page it drags near the top or bottom
			if (settings.scroll) {
				var scrollZone = 30;
				var scrollSpeed = 5;
				var scrollTop = Viewport.scroll().y;
				var pageHeight = Viewport.page().y;
				var clientHeight = Viewport.frame().y;

				if ((scrollTop + clientHeight + 2 * scrollZone) < pageHeight
						&& mousePos.y > (scrollTop + clientHeight - scrollZone)) {

		            if ($.lDrag.scrollDirection != "down"){
		                $.lDrag.scrollDirection = "down";
		                $.lDrag.scroll();
		            }
				}
				else if (scrollTop > 0 && mousePos.y < (scrollTop + scrollZone)) {
		            if ($.lDrag.scrollDirection != "up"){
		                $.lDrag.scrollDirection = "up";
		                $.lDrag.scroll();
		            }
				}
				else {
		            $.lDrag.scrollDirection = "";
				}
			}
		}
	});
})(jQuery);
// file seperator

(function ($) {
	$.fn.lResize = function(options) {
		this.each(function() {
			$.lResize(this, options);
		});
	};

	$.fn.lResizeBind = $.fn.lDragBind;

	$.fn.lResizeHandleRule = function(options) {
		this.each(function() {
			options.handle = this;
			$.lResize.handleRule(options);
		});
	};

	$.lResize = function(container, options) {
		/* OPTIONS
		 * handle (object): resize handle
		 * onStart (function): execute when start
		 * onMove (function): execute when resizing
		 * onComplete (function): execute when completed
		 */
		$.lResize.create(container, options);
	};

	$.lResize.extendNativeFunctionObject({

		/* Resize direction */
		HORIZONTAL : "horizontal",
		VERTICAL : "vertical",

		/* Resize modes */
		ADD : "add",
		SUBTRACT : "subtract",

		resizeRule: function(container, direction, mode) {
			this.container = container;
			this.direction = direction;
			this.next = null;
			this.origWidth = null;
			this.origHeight = null;
			this.mode = mode;
		},

		handleRule: function(options) {
			var handle = options.handle;

			if (typeof handle == "string") {
				handle = $(handle);
			}

			var settings = handle.resizeSettings;

			if (!settings) {
				$.lResize.create(settings.container, settings)
			}
			else {
				settings.resizeRules.push(new $.lResize.resizeRule(
					settings.container, settings.direction, settings.mode));
			}
		},

		bind: function(container, type, fn) {
			$.lDrag.bind(container, type, fn);
		},

		create: function(container, options) {
			if (options.handle && options.direction && options.mode) {
    			if (typeof options.handle == "string") {
    				options.handle = $(options.handle)[0];
    			}

				var handle = options.handle;

				if (!handle.resizeSettings) {
					handle.resizeSettings = options;
				}

				var settings = handle.resizeSettings;

				if (!handle.dragSettings || !handle.dragSettings.isResizeHandle) {
					$.lDrag.create(handle, {
						onStart: $.lResize.onMouseDown,
						onMove: $.lResize.onResize,
						onComplete: $.lResize.onMouseUp,
						noDrag: !options.drag,
						isResizeHandle: true
					});
				}

				var jHandle = $(handle);
				jHandle.lDragBind("start", options.onStart);
				jHandle.lDragBind("move", options.onMove);
				jHandle.lDragBind("complete", options.onComplete);

				if (!settings.resizeRules) {
					settings.resizeRules = [];
				}

				settings.resizeRules.push(new $.lResize.resizeRule(container, options.direction, options.mode));
			}
		},

		onMouseDown : function() {
			var handle = $.lDrag.container;
			var settings = handle.resizeSettings;
			var mouse = mousePos;

			settings.mouseStart = new Coordinate(mousePos.x, mousePos.y);

			for (var i = 0; i < settings.resizeRules.length; i++) {
				var resizeRule = settings.resizeRules[i];
				var jContainer = $(resizeRule.container);

				resizeRule.origWidth = jContainer.width();
				resizeRule.origHeight = jContainer.height();
			}
		},

		onResize: function() {
			var handle = $.lDrag.container;
			var settings = handle.resizeSettings;
			var mouse = mousePos;
			var mouseDelta = mousePos.minus(settings.mouseStart);

			var newLength;
			var lengthCorrection = 0;
			var noChange = false;

			for (var i = 0; i < settings.resizeRules.length; i++) {
				var resizeRule = settings.resizeRules[i];
				var jContainer = $(resizeRule.container);

				if (resizeRule.direction == $.lResize.HORIZONTAL) {
					resizeRule.prevLength = jContainer.width();

					if (resizeRule.mode == $.lResize.ADD) {
						newLength = resizeRule.origWidth + mouseDelta.x;
					}
					else {
						newLength = resizeRule.origWidth - mouseDelta.x
					}
				}
				else if (resizeRule.direction == $.lResize.VERTICAL) {
					resizeRule.prevLength = jContainer.height();

					if (resizeRule.mode == $.lResize.ADD) {
						newLength = resizeRule.origHeight + mouseDelta.y;
					}
					else {
						newLength = resizeRule.origHeight - mouseDelta.y;
					}
				}

				resizeRule.newLength = newLength;

				if (newLength < 1) {
					lengthCorrection = Math.max(-newLength + 1, lengthCorrection);
					newLength = 1;
				}

				if (newLength == resizeRule.prevLength) {
					noChange = true;
				}
			}

			for (var i = 0; i < settings.resizeRules.length; i++) {
				var resizeRule = settings.resizeRules[i];
				var jContainer = $(resizeRule.container);

				if (!settings.disableStop && noChange) {
					newLength = resizeRule.prevLength;
				}
				else if (resizeRule.newLength < 1) {
					newLength = resizeRule.newLength + lengthCorrection;
				}
				else {
					newLength = resizeRule.newLength - lengthCorrection;
				}

				if (resizeRule.direction == $.lResize.HORIZONTAL) {
						jContainer.width(newLength);
				}
				else if (resizeRule.direction == $.lResize.VERTICAL) {
						jContainer.height(newLength);
				}
			}
		},

		onMouseUp: function() {
			var handle = $.lDrag.container;
			var settings = handle.resizeSettings;

			settings.mouseEnd = new Coordinate(mousePos.x, mousePos.y);
		}
	});
})(jQuery);
// file seperator

(function($){
	$.Popup = function(options) {
		return $.Popup.open(options);
	};

	$.Popup.extendNativeFunctionObject({
		close: function(link) {
			jQuery(link).parents(".popup:first").remove();

			var jModal = jQuery("#alert-messages .modal:last");

			if (jModal.length) {
				jModal.before(jQuery("#alert-messages .alert-background"));
			}
			else {
				var jBg = jQuery("#alert-messages .alert-background");

				jBg.fadeTo("normal", 0, function() {
					jBg.remove();
				});

				jQuery(window).unbind("resize", $.Popup.center);
				jQuery(window).unbind("resize", $.Popup.resize);
				jQuery(window).unbind("scroll", $.Popup.center);
			}

			if (jQuery.browser.msie &&
				jQuery.browser.version.number() < 7 &&
				$.Popup.count() == 0) {

				jQuery("select").css("visibility", "visible");
			}
		},

		count: function() {
			return jQuery("#alert-messages .popup").length;
		},

		open: function(options) {
			/*
			 * OPTIONS:
			 * modal (boolean) - show shaded background
			 * message (string|object) - default HTML/object to display
			 * noCenter (boolean) - prevent re-centering
			 * height (int) - starting height of message box
			 * width (int) - starting width of message box
			 * onClose (function) - executes after closing
			 */

			options = options || {};

			var modal = options.modal;
			var myMessage = options.message;
			var msgHeight = options.height;
			var msgWidth = options.width;
			var noCenter = options.noCenter;
			var title = options.title;
			var onClose = options.onClose;

			var jAlertMsgs = jQuery("#alert-messages");

			if (!jAlertMsgs.length) {
				jQuery("body").append("<div id='alert-messages' style='position:absolute; top:0; left:0; z-index:" + Liferay.zIndex.ALERT + "'></div>");
				jAlertMsgs = jQuery("#alert-messages");
			}


			jAlertMsgs.append(
				"<div class='popup " + (modal ? "modal" : "") + "' style='position:absolute; top:0; left:0;'>" +
					"<div class='popup-inner'>" +
						"<div class='popup-header'>" +
							"<span class='popup-title'>" + (title || "&nbsp;") + "</span>" +
							"<img class='popup-close' src='" + themeDisplay.getPathThemeImages() + "/portlet/close.png'/>" +
						"</div>" +
						"<div class='popup-message'></div>" +
					"</div>" +
				"</div>");

			var jPopup = jAlertMsgs.find(".popup:last");
			var jMessage = jPopup.find(".popup-message");

			jPopup.find(".popup-close").click(function() {
				$.Popup.close(this);
			});

			if (onClose != null) {
				jPopup.find(".popup-close").click(onClose);
			}

			jPopup[0].alertOptions = options;

			jMessage.append(myMessage || "<div class=\"loading-animation\"></div>");

			if (msgHeight) {
				jMessage.css(jQuery.browser.msie ? "height" : "min-height", msgHeight + "px");
			}

			if (msgWidth) {
				jPopup.css("width", msgWidth + "px");
			}

			jPopup.mousedown(function() {
				if (this != jQuery("#alert-messages .popup:last")[0]) {
					jQuery("#alert-messages").append(this);
				}
			});

			var jBg = jAlertMsgs.find(".alert-background");

			if (modal) {
				if (jBg.length) {
					jPopup.before(jBg[0]);
				}
				else {
					jPopup.before("<div class='alert-background' style='position:absolute; top:0; left:0'></div>");
					jBg = jAlertMsgs.find(".alert-background");
					jBg.css({display: "none", opacity: 0});
				}
			}

			if (jQuery.browser.msie &&
				jQuery.browser.version.number("round") < 7 &&
				$.Popup.count() == 1) {

				jQuery('select').css('visibility', 'hidden');
				jPopup.find('select').css('visibility', 'visible');
			}

			if (jAlertMsgs.find(".popup").length == 1) {
				jQuery(window).resize($.Popup.center);
				jQuery(window).resize($.Popup.resize);
				jQuery(window).scroll($.Popup.center);
			}

			$.Popup.resize();
			jBg.fadeTo("normal", 0.5);

			if (false) {
				// jQuery Draggable is slow.  Use Liferay Drag (lDrag)
				jPopup.Draggable({
					handle: jPopup.find(".popup-header")[0],
					zIndex: Liferay.zIndex.ALERT + 1
				});
			}
			else {
				jPopup.lDrag({
					handle: jPopup.find(".popup-header")[0],
					threshold: 2,
					dragClass: "drag-indicator"
				});
			}

			if (noCenter) {
				$.Popup.center();
			}
			else {
				$.Popup.center(msgHeight, msgWidth);
			}

			Liferay.Util.addInputType(jPopup[0]);
			Liferay.Util.addInputFocus(jPopup[0]);
			window.focus();

			return jMessage[0];
		},

		iframe : function(url, options) {
			var msgHeight = options.height;
			var msgWidth = options.width;
			var message = $.Popup.open(options);
			var iframe = document.createElement("iframe");

			message.height = "";
			iframe.src = url;
			iframe.frameBorder = 0;
			if (msgWidth) iframe.style.width = "100%";

			message.appendChild(iframe);
			if (!options.noCenter) {
				$.Popup.center(msgHeight, msgWidth);
			}

			return message;
		},

		center : function(height, width) {
			var jPopup = jQuery("#alert-messages .popup:last");

			if (!jPopup[0].alertOptions.noCenter) {
				jPopup.css({
					top: (Viewport.scroll().y + (Viewport.frame().y/2 - jPopup.height()/2)) + "px",
					left: (Viewport.scroll().x + (Viewport.frame().x/2 - jPopup.width()/2)) + "px"
				});
			}
		},

	    resize: function() {
			jQuery("#alert-messages .alert-background").css({
				height: Viewport.page().y + "px",
				width: Viewport.page().x + "px"
			});
	    },

	    resizeIframe: function(options) {
	    	if ($.Popup.message && options) {
	    		var iframe = $.Popup.message.getElementsByTagName("iframe")[0];
				var loading = jQuery.getOne(".loading-animation", $.Popup.message);

				if (loading) {
					loading.parentNode.removeChild(loading);
				}

	    		if (iframe) {
		    		if (options.height) {
		    			iframe.height = options.height;
		    		}

		    		if (options.width) {
		    			iframe.width = options.width;
		    		}
	    		}
	    	}

	    	$.Popup.resize();
	    }
	});
})(Liferay);
// file seperator

var DragLink = {
	create: function(item, dragId) {
		item.dragId = _$J.getOne(dragId);
		item.clickLink = item.href;
		item.href = "javascript:void(0)";
		item.onclick = DragLink.onLinkClick;
	},

	onLinkClick: function() {
		if (this.dragId.wasClicked) {
			if (Liferay.Browser.is_ie) {
				setTimeout("window.location = \"" + this.clickLink + "\";", 0);
			}
			else {
				window.location = this.clickLink;
			}
		}
	}
};

var NavFlyout = {
	zIndex: 1,
	initialize: function (nav) {
		var nav = _$J.getOne(nav);
		var navMapList = _$J("portlet-nav-map-list", nav);

		navMapList.not(".portlet-nav-map-level_1, .portlet-nav-map-level_2")
			.css({position: "absolute", display: "none"});

		_$J(".portlet-nav-map-list a", nav).each(function(){
			var item = _$J(this.parentNode.parentNode);
				if (item.is(".portlet-nav-map-level_1")) {
					item.mouseover(function() {
						NavFlyout.hide(this.parentNode);
					});
				}
				else {
					item.mouseover(NavFlyout.onHoverOver);
				}
		});
	},

	initToggle: function(nav, imgSrc) {
		var nav = _$J.getOne(nav);
		var navMapList = _$J(".portlet-nav-map-level_1 > li", nav);
		navMapList.click(NavFlyout.onToggle);
		navMapList.css({ backgroundImage: "url(" + imgSrc + ")" });
	},

	hide: function(listItem) {
		NavFlyout.initialize(listItem.parentNode);
	},

	onHoverOver: function() {
		var listItem = this.parentNode;

		// Hide all other submenus
		if (_$J(listItem.parentNode).is(".portlet-nav-map-level_2")) {
			NavFlyout.hide(listItem.parentNode.parentNode.parentNode);
		}
		else {
			NavFlyout.hide(listItem);
		}

		// Show current submenu
		_$J(listItem.childNodes).filter("ul")
			.css({
				display: "block",
				top: "5px",
				left: "100px"
			});

		// Fix Z-Index
		zItem = listItem;
		while (zItem.nodeName.toLowerCase() != "div") {
			if (zItem.nodeName.toLowerCase() == "li") {
				zItem.style.zIndex = NavFlyout.zIndex;
			}
			zItem = zItem.parentNode;
		}

		NavFlyout.zIndex++;
	},

	onToggle: function() {
		var subMenu = _$J("ul:first", this).get(0);

		if (this.isShowing) {
			subMenu.style.display = "none";
			this.style.backgroundImage = this.style.backgroundImage.replace(/02_minus/, "02_plus");
			this.isShowing = false;
		}
		else {
			subMenu.style.display = "block";
			subMenu.style.backgroundImage = "none";
			this.style.backgroundImage = this.style.backgroundImage.replace(/02_plus/, "02_minus");
			this.isShowing = true;
		}
	}
};

var PortletHeaderBar = {
	mode: {},

	fade: function(data) {
		var count = data.count;
		var id = data.id;

		var changed = false;
		var icons = _$J("#portlet-header-bar_" + id + " .portlet-small-icon-bar");

		if (PortletHeaderBar.mode[id] == "in") {
			if (count <= 10) {
				if (count >= 0) {
					icons.css({"opacity": (count/10), "display": ""});
				}
				changed = true;
				data.count++;
			}
		}
		else if (PortletHeaderBar.mode[id] == "out") {
			if (count >= 0) {
				if (count <= 10) {
					icons.css("opacity", (count/10));
				}
				data.count--;
				changed = true;
			}
			else {
				icons.css("display", "none");
			}
		}

		return changed;
	},

	hide: function (id) {
		this.mode[id] = "out";
		Liferay.Animate("header-icon-fade_" + id,
			PortletHeaderBar.fade,
			{ count: 15, id: id }
		);
	},

	show: function (id) {
		this.mode[id] = "in";
		Liferay.Animate("header-icon-fade_" + id,
			PortletHeaderBar.fade,
			{ count: -5, id: id }
		);
	}
};

var PhotoSlider = Class.create();
PhotoSlider.prototype = {

	initialize: function (slidingWindow, windowWidth, photos, totalPages, varName) {
		this.TOTAL_FRAMES = 20;
		this.count = 0;
		this.page = 0;
		this.timer = 0;
		this.start = 0;

		this.photos = _$J.getOne(photos);
		this.photos.style.position = "relative";
		this.photos.style.left = "0px";

		this.slidingWindow = _J$.getOne(slidingWindow);
		this.windowWidth = windowWidth;
		this.totalPages = totalPages;
		this.varName = varName;
	},

	animate: function() {
		if (this.count <= this.TOTAL_FRAMES) {
			var ratio = this.count / this.TOTAL_FRAMES;
			var ratio2 = Math.sin(ratio * (Math.PI/2));
			var delta = -(this.page * this.windowWidth) - this.start;

			this.photos.style.left = this.start + (delta * ratio2);
			this.count++;
			this.timer = setTimeout(this.varName + ".animate()", 30);
		}
		else {
			this.timer = 0;
		}
	},

	left: function() {
		this.start = parseInt(this.photos.style.left);

		if (this.page > 0) {
			this.page--;
			this.count = 0;

			if (!this.timer) {
				this.timer = setTimeout(this.varName + ".animate()", 30);
			}
		}
	},

	right: function() {
		this.start = parseInt(this.photos.style.left);

		if (this.page < (this.totalPages - 1)) {
			this.page++;
			this.count = 0;

			if (!this.timer) {
				this.timer = setTimeout(this.varName + ".animate()", 30);
			}
		}
	}
};

var Tabs = {
	show : function (namespace, names, id) {
		var el = document.getElementById(namespace + id + "TabsId");

		if (el) {
			el.className = "current";
		}

		el = document.getElementById(namespace + id + "TabsSection");

		if (el) {
			el.style.display = "block";
		}

		for (var i = 0; (names.length > 1) && (i < names.length); i++) {
			if (id != names[i]) {
				el = document.getElementById(namespace + names[i] + "TabsId");

				if (el) {
					el.className = "none";
				}

				el = document.getElementById(namespace + names[i] + "TabsSection");

				if (el) {
					el.style.display = "none";
				}
			}
		}
	}
};

var StarRating = new Class({
	initialize: function(id, options) {
		/* OPTIONS
		 * displayOnly: (boolean) non-modifiable display
		 * onComplete: (function) executes when rating is selected
		 * rating: rating to initialize to
		 */
			this.options = options || {};
			this.rating = this.options.rating || 0;
			var item = _$J("#" + id);
			this.stars = item.find("img");
			var self = this;

			if (!this.options.displayOnly) {
				item.bind("mouseout",  {self: this}, this.onHoverOut);

				this.stars.each(function(index) {
					this.index = index + 1;
					_$J(this).bind("click", {self: self}, self.onClick)
						   .bind("mouseover", {self: self}, self.onHoverOver);
				})
			}

			this.display(this.rating, "rating");
		}
	});

StarRating.implement({
	display: function(rating, mode) {
		var self = this;
		rating = rating == null ? this.rating : rating;

		var whole = Math.floor(rating);
		var fraction = rating - whole;

		this.stars.each(function(index) {
			image = this;
			if (index < whole) {
				if (mode == "hover") {
					image.src = image.src.replace(/\bstar_.*\./, "star_hover.");
				}
				else {
					image.src = image.src.replace(/\bstar_.*\./, "star_on.");
				}
			}
			else {
				if (fraction < 0.25) {
					image.src = image.src.replace(/\bstar_.*\./, "star_off.");
				}
				else if (fraction < 0.50) {
					image.src = image.src.replace(/\bstar_.*\./, "star_on_quarter.");
				}
				else if (fraction < 0.75) {
					image.src = image.src.replace(/\bstar_.*\./, "star_on_half.");
				}
				else if (fraction < 1.00) {
					image.src = image.src.replace(/\bstar_.*\./, "star_on_threequarters.");
				}
				fraction = 0;
			}
		});
	},

	onHoverOver: function(event) {
		event.data.self.display(this.index, "hover");
	},
	onHoverOut: function(event) {
		event.data.self.display();
	},
	onClick: function(event) {
		var target = this;
		var newRating = target.index;
		var self = event.data.self;
		self.rating = newRating;

		if (self.options.onComplete) {
			self.options.onComplete(newRating);
		}

		self.display(newRating);
	}
});

var ToolTip = {
	container: null,

	show: function(event, obj, text) {
		var instance = this;

		var container = instance.container;
		var currentItem = jQuery(obj);
		var position = currentItem.offset();

		if (!container) {
			container = jQuery('<div class="portal-tool-tip"></div>').appendTo('body');

			instance.container = container;
		}

		container.html(text);

		container.show();

		var width = container.width();

		container.css(
			{
				cursor: 'default',
				left: (position.left - (width + 5)) + 'px',
				position: 'absolute',
				top: (position.top - 15) +'px'
			}
		);

		currentItem.one('mouseout',
			function() {
				instance.hide();
			}
		);
	},

	hide: function(event) {
		var instance = this;

		instance.container.hide();
	}
};
// file seperator

Liferay.Portlet = {
	fn: {},
	fnAll: [],
	fnLast: [],
	ajaxList: {},
	list: {},

	isAjax: function(id) {
		return (this.ajaxList[id] == 1);
	},

	flagAjax: function(id) {
		this.ajaxList[id] = 1;
	},

	process: function(id) {
		var status = this.list[id];
		var count = 0;

		this.list[id] = 0;

		if (status == 1) {
			this.processPortlet(id);
			this.processAll(id);
		}
		else if (status == 0) {
			// Already processed. Do nothing.
		}
		else {
			// New portlet. Process and mark.
			this.processPortlet(id);
		}

		for (var i in this.list) {
			count += this.list[i];
		}

		if (count == 0) {
			this.processLast(id);
		}
	},

	processAll: function(id) {
		for (var i = 0; i < this.fnAll.length; i++) {
			this.fnAll[i](id, _$J("#p_p_id_" + id + "_"));
		}
	},

	processPortlet: function(id) {
		if (this.fn[id]) {
			for (var i = 0; i < this.fn[id].length; i++) {
				this.fn[id][i](id, _$J("#p_p_id_" + id + "_"));
			}
			this.fn[id] = [];
		}
	},

	processLast: function(id) {
		for (var i = 0; i < this.fnLast.length; i++) {
			this.fnLast[i](id);
		}
		this.fnLast = [];
	},

	ready: function(arg1, arg2) {
		if (typeof arg1 == "function") {
			this.fnAll.push(arg1);
		}
		else if (typeof arg1 == "string" && typeof arg2 == "function") {
			if (!this.fn[arg1]) {
				this.fn[arg1] = [];
			}

			this.fn[arg1].push(arg2);
		}
	},

	remove: function(id) {
		this.ajaxList[id] = 0;
		this.list[id] = 1;
		this.fn[id] = [];
	},

	last: function(arg1) {
		this.fnLast.push(arg1);
	},

	/*
	 * Helper methods for portlets
	 */
	findIndex: function(portlet) {
		var index = -1;

		_$J(".portlet-boundary", portlet.parentNode).each(function(i) {
			if (this == portlet) {
				index = i;
			}
		});

		return index;
	},

	move: function(data) {
		var portlet = data.portlet;
		var neighbor = data.neighbor;
		var quadrant = data.quadrant;
		var container = data.container;

		if (neighbor && quadrant) {
			if (quadrant == 1 || quadrant == 2) {
				jQuery(neighbor).before(portlet);
			}
			else {
				jQuery(neighbor).after(portlet);
			}
		}
		else if (container) {
			jQuery(container).append(portlet);
		}

		this.savePosition(portlet);
	},

	savePosition: function(portlet) {
		var currentColumnId = portlet.parentNode.id.replace(/^layout-column_/, '');
		var index = this.findIndex(portlet);
		var portletId = portlet.id.replace(/^(p_p_id_)/, '');
		portletId = portletId.substring(0, portletId.length - 1);

		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/update_layout" +
			"?p_l_id=" + themeDisplay.getPlid() +
			"&p_p_id=" + portletId +
			"&p_p_col_id=" + currentColumnId +
			"&p_p_col_pos=" + index +
			"&doAsUserId=" + themeDisplay.getDoAsUserIdEncoded() +
			"&cmd=move");
	}
};

jQuery.fn.last = function(fn) {
	Liferay.Portlet.last(fn);
};
// file seperator

Liferay.Publisher = {
	publishers: {},

	deliver: function(publisher) {
		var instance = this;

		var scope = window;
		var data;

		if (arguments.length == 2) {
			data = [arguments[1]];
		}
		else {
			data = jQuery.map(arguments,
				function(item, i) {
					 return (i > 0) ? item : null;
				}
			);
		}

		jQuery.each(instance.publishers[publisher],
			function(i, el) {
				var classScope = el.obj || scope;
				el.func.apply(classScope, data);
			}
		);
	},

	register: function(publisher) {
		var instance = this;

		if (!instance.publishers[publisher]) {
			instance.publishers[publisher] = [];
		}
	},

	subscribe: function(publisher, func, obj) {
		var instance = this;

		if (instance.publishers[publisher] == null) {
			instance.register(publisher);
		}

		var alreadyExists = false;

		jQuery.each(instance.publishers[publisher],
			function(i, el) {
				if (el === func) {
					alreadyExists = true;
					return false;
				}
			}
		);

		if (!alreadyExists) {
			var data = {
				func: func,
				obj: obj || null
			};

			instance.publishers[publisher].push(data);
		}

	},

	unsubscribe: function(publisher, func) {
		var instance = this;

		if (!instance.publishers[publisher]) {
			return;
		}

		 jQuery.each(instance.publishers[publisher],
			function(i, el) {
				if (el.func === func) {
					instance.publishers[publisher].pop(el);
					return false;
				}
			}
		);
	}
};
// file seperator

Liferay.Service = {
	url: themeDisplay.getPathMain() + "/portal/json_service",

	classNameSuffix: "ServiceJSON",

	ajax: function(params, callback) {
		params.serviceParameters = Liferay.Service.getParameters(params);

		if (callback) {
			_$J.getJSON(Liferay.Service.url, params, callback);
		}
		else {
			var xHR = _$J.ajax(
				{
					url: Liferay.Service.url,
					data: params,
					dataType: 'json',
					async: false
				}
			);

			return eval("(" + xHR.responseText + ")");
		}
	},

	getParameters: function(params) {
		var serviceParameters = "";

		for (var key in params) {
			if ((key != "serviceClassName") && (key != "serviceMethodName")) {
				serviceParameters += key + ",";
			}
		}

		if (endsWith(serviceParameters, ",")) {
			serviceParameters = serviceParameters.substring(0, serviceParameters.length - 1);
		}

		return serviceParameters;
	}
};

Liferay.Service.Portal = {
	servicePackage: "com.liferay.portal.service.http."
};

Liferay.Service.Portal.Address = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Address" + Liferay.Service.classNameSuffix,

	addAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addAddress";

		return Liferay.Service.ajax(params, callback);
	},

	deleteAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteAddress";

		return Liferay.Service.ajax(params, callback);
	},

	getAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getAddress";

		return Liferay.Service.ajax(params, callback);
	},

	getAddresses: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getAddresses";

		return Liferay.Service.ajax(params, callback);
	},

	updateAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateAddress";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.ClassName = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "ClassName" + Liferay.Service.classNameSuffix,

	getClassName: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getClassName";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Company = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Company" + Liferay.Service.classNameSuffix,

	addCompany: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addCompany";

		return Liferay.Service.ajax(params, callback);
	},

	updateCompany: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateCompany";

		return Liferay.Service.ajax(params, callback);
	},

	updateDisplay: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateDisplay";

		return Liferay.Service.ajax(params, callback);
	},

	updateSecurity: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateSecurity";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Country = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Country" + Liferay.Service.classNameSuffix,

	getCountries: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCountries";

		return Liferay.Service.ajax(params, callback);
	},

	getCountry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCountry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.EmailAddress = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "EmailAddress" + Liferay.Service.classNameSuffix,

	addEmailAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addEmailAddress";

		return Liferay.Service.ajax(params, callback);
	},

	deleteEmailAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteEmailAddress";

		return Liferay.Service.ajax(params, callback);
	},

	getEmailAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEmailAddress";

		return Liferay.Service.ajax(params, callback);
	},

	getEmailAddresses: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEmailAddresses";

		return Liferay.Service.ajax(params, callback);
	},

	updateEmailAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEmailAddress";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Group = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Group" + Liferay.Service.classNameSuffix,

	addGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addGroup";

		return Liferay.Service.ajax(params, callback);
	},

	addRoleGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addRoleGroups";

		return Liferay.Service.ajax(params, callback);
	},

	deleteGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteGroup";

		return Liferay.Service.ajax(params, callback);
	},

	getGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getGroup";

		return Liferay.Service.ajax(params, callback);
	},

	getOrganizationsGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getOrganizationsGroups";

		return Liferay.Service.ajax(params, callback);
	},

	getUserGroupsGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserGroupsGroups";

		return Liferay.Service.ajax(params, callback);
	},

	hasUserGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasUserGroup";

		return Liferay.Service.ajax(params, callback);
	},

	search: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "search";

		return Liferay.Service.ajax(params, callback);
	},

	searchCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "searchCount";

		return Liferay.Service.ajax(params, callback);
	},

	setRoleGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setRoleGroups";

		return Liferay.Service.ajax(params, callback);
	},

	unsetRoleGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetRoleGroups";

		return Liferay.Service.ajax(params, callback);
	},

	updateGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateGroup";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Layout = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Layout" + Liferay.Service.classNameSuffix,

	addLayout: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addLayout";

		return Liferay.Service.ajax(params, callback);
	},

	deleteLayout: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteLayout";

		return Liferay.Service.ajax(params, callback);
	},

	getLayoutName: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getLayoutName";

		return Liferay.Service.ajax(params, callback);
	},

	getLayoutReferences: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getLayoutReferences";

		return Liferay.Service.ajax(params, callback);
	},

	setLayouts: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setLayouts";

		return Liferay.Service.ajax(params, callback);
	},

	updateLayout: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateLayout";

		return Liferay.Service.ajax(params, callback);
	},

	updateLookAndFeel: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateLookAndFeel";

		return Liferay.Service.ajax(params, callback);
	},

	updateName: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateName";

		return Liferay.Service.ajax(params, callback);
	},

	updateParentLayoutId: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateParentLayoutId";

		return Liferay.Service.ajax(params, callback);
	},

	updatePriority: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePriority";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.LayoutSet = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "LayoutSet" + Liferay.Service.classNameSuffix,

	updateLookAndFeel: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateLookAndFeel";

		return Liferay.Service.ajax(params, callback);
	},

	updateVirtualHost: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateVirtualHost";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.ListType = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "ListType" + Liferay.Service.classNameSuffix,

	getListType: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getListType";

		return Liferay.Service.ajax(params, callback);
	},

	getListTypes: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getListTypes";

		return Liferay.Service.ajax(params, callback);
	},

	validate: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "validate";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Organization = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Organization" + Liferay.Service.classNameSuffix,

	addGroupOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addGroupOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	addPasswordPolicyOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addPasswordPolicyOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	addOrganization: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addOrganization";

		return Liferay.Service.ajax(params, callback);
	},

	deleteOrganization: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteOrganization";

		return Liferay.Service.ajax(params, callback);
	},

	getOrganization: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getOrganization";

		return Liferay.Service.ajax(params, callback);
	},

	getOrganizationId: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getOrganizationId";

		return Liferay.Service.ajax(params, callback);
	},

	getUserOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	setGroupOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setGroupOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	unsetGroupOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetGroupOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	unsetPasswordPolicyOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetPasswordPolicyOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	updateOrganization: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateOrganization";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.OrgLabor = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "OrgLabor" + Liferay.Service.classNameSuffix,

	addOrgLabor: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addOrgLabor";

		return Liferay.Service.ajax(params, callback);
	},

	deleteOrgLabor: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteOrgLabor";

		return Liferay.Service.ajax(params, callback);
	},

	getOrgLabor: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getOrgLabor";

		return Liferay.Service.ajax(params, callback);
	},

	getOrgLabors: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getOrgLabors";

		return Liferay.Service.ajax(params, callback);
	},

	updateOrgLabor: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateOrgLabor";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.PasswordPolicy = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "PasswordPolicy" + Liferay.Service.classNameSuffix,

	addPasswordPolicy: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addPasswordPolicy";

		return Liferay.Service.ajax(params, callback);
	},

	deletePasswordPolicy: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deletePasswordPolicy";

		return Liferay.Service.ajax(params, callback);
	},

	updatePasswordPolicy: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePasswordPolicy";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Permission = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Permission" + Liferay.Service.classNameSuffix,

	checkPermission: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "checkPermission";

		return Liferay.Service.ajax(params, callback);
	},

	hasGroupPermission: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasGroupPermission";

		return Liferay.Service.ajax(params, callback);
	},

	hasUserPermission: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasUserPermission";

		return Liferay.Service.ajax(params, callback);
	},

	hasUserPermissions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasUserPermissions";

		return Liferay.Service.ajax(params, callback);
	},

	setGroupPermissions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setGroupPermissions";

		return Liferay.Service.ajax(params, callback);
	},

	setOrgGroupPermissions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setOrgGroupPermissions";

		return Liferay.Service.ajax(params, callback);
	},

	setRolePermission: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setRolePermission";

		return Liferay.Service.ajax(params, callback);
	},

	setUserPermissions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setUserPermissions";

		return Liferay.Service.ajax(params, callback);
	},

	unsetRolePermission: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetRolePermission";

		return Liferay.Service.ajax(params, callback);
	},

	unsetRolePermissions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetRolePermissions";

		return Liferay.Service.ajax(params, callback);
	},

	unsetUserPermissions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetUserPermissions";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Phone = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Phone" + Liferay.Service.classNameSuffix,

	addPhone: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addPhone";

		return Liferay.Service.ajax(params, callback);
	},

	deletePhone: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deletePhone";

		return Liferay.Service.ajax(params, callback);
	},

	getPhone: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getPhone";

		return Liferay.Service.ajax(params, callback);
	},

	getPhones: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getPhones";

		return Liferay.Service.ajax(params, callback);
	},

	updatePhone: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePhone";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Portal = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Portal" + Liferay.Service.classNameSuffix,

	test: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "test";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.PluginSetting = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "PluginSetting" + Liferay.Service.classNameSuffix,

	updatePluginSetting: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePluginSetting";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Portlet = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Portlet" + Liferay.Service.classNameSuffix,

	updatePortlet: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePortlet";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Region = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Region" + Liferay.Service.classNameSuffix,

	getRegions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getRegions";

		return Liferay.Service.ajax(params, callback);
	},

	getRegion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getRegion";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Resource = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Resource" + Liferay.Service.classNameSuffix,

	getResource: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getResource";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Role = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Role" + Liferay.Service.classNameSuffix,

	addRole: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addRole";

		return Liferay.Service.ajax(params, callback);
	},

	deleteRole: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteRole";

		return Liferay.Service.ajax(params, callback);
	},

	getGroupRole: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getGroupRole";

		return Liferay.Service.ajax(params, callback);
	},

	getGroupRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getGroupRoles";

		return Liferay.Service.ajax(params, callback);
	},

	getRole: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getRole";

		return Liferay.Service.ajax(params, callback);
	},

	getUserGroupRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserGroupRoles";

		return Liferay.Service.ajax(params, callback);
	},

	getUserRelatedRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserRelatedRoles";

		return Liferay.Service.ajax(params, callback);
	},

	getUserRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserRoles";

		return Liferay.Service.ajax(params, callback);
	},

	hasUserRole: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasUserRole";

		return Liferay.Service.ajax(params, callback);
	},

	hasUserRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasUserRoles";

		return Liferay.Service.ajax(params, callback);
	},

	updateRole: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateRole";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.User = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "User" + Liferay.Service.classNameSuffix,

	addGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	addPasswordPolicyUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addPasswordPolicyUsers";

		return Liferay.Service.ajax(params, callback);
	},

	addRoleUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addRoleUsers";

		return Liferay.Service.ajax(params, callback);
	},

	addUserGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addUserGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	addUser: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addUser";

		return Liferay.Service.ajax(params, callback);
	},

	deleteRoleUser: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteRoleUser";

		return Liferay.Service.ajax(params, callback);
	},

	deleteUser: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteUser";

		return Liferay.Service.ajax(params, callback);
	},

	getDefaultUserId: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefaultUserId";

		return Liferay.Service.ajax(params, callback);
	},

	getGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	getRoleUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getRoleUsers";

		return Liferay.Service.ajax(params, callback);
	},

	getUserByEmailAddress: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserByEmailAddress";

		return Liferay.Service.ajax(params, callback);
	},

	getUserById: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserById";

		return Liferay.Service.ajax(params, callback);
	},

	getUserByScreenName: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserByScreenName";

		return Liferay.Service.ajax(params, callback);
	},

	hasGroupUser: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasGroupUser";

		return Liferay.Service.ajax(params, callback);
	},

	hasRoleUser: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "hasRoleUser";

		return Liferay.Service.ajax(params, callback);
	},

	setGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	setRoleUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setRoleUsers";

		return Liferay.Service.ajax(params, callback);
	},

	setUserGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "setUserGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	unsetGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	unsetPasswordPolicyUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetPasswordPolicyUsers";

		return Liferay.Service.ajax(params, callback);
	},

	unsetRoleUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetRoleUsers";

		return Liferay.Service.ajax(params, callback);
	},

	unsetUserGroupUsers: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetUserGroupUsers";

		return Liferay.Service.ajax(params, callback);
	},

	updateActive: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateActive";

		return Liferay.Service.ajax(params, callback);
	},

	updateAgreedToTermsOfUse: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateAgreedToTermsOfUse";

		return Liferay.Service.ajax(params, callback);
	},

	updateLockout: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateLockout";

		return Liferay.Service.ajax(params, callback);
	},

	updateOrganizations: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateOrganizations";

		return Liferay.Service.ajax(params, callback);
	},

	updatePassword: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePassword";

		return Liferay.Service.ajax(params, callback);
	},

	updatePortrait: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePortrait";

		return Liferay.Service.ajax(params, callback);
	},

	updateUser: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateUser";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.UserGroup = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "UserGroup" + Liferay.Service.classNameSuffix,

	addGroupUserGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addGroupUserGroups";

		return Liferay.Service.ajax(params, callback);
	},

	addUserGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addUserGroup";

		return Liferay.Service.ajax(params, callback);
	},

	deleteUserGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteUserGroup";

		return Liferay.Service.ajax(params, callback);
	},

	getUserGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserGroup";

		return Liferay.Service.ajax(params, callback);
	},

	getUserUserGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserUserGroups";

		return Liferay.Service.ajax(params, callback);
	},

	unsetGroupUserGroups: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsetGroupUserGroups";

		return Liferay.Service.ajax(params, callback);
	},

	updateUserGroup: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateUserGroup";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.UserGroupRole = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "UserGroupRole" + Liferay.Service.classNameSuffix,

	addUserGroupRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addUserGroupRoles";

		return Liferay.Service.ajax(params, callback);
	},

	deleteUserGroupRoles: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteUserGroupRoles";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Portal.Website = {
	serviceClassName: Liferay.Service.Portal.servicePackage + "Website" + Liferay.Service.classNameSuffix,

	addWebsite: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addWebsite";

		return Liferay.Service.ajax(params, callback);
	},

	deleteWebsite: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteWebsite";

		return Liferay.Service.ajax(params, callback);
	},

	getWebsite: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getWebsite";

		return Liferay.Service.ajax(params, callback);
	},

	getWebsites: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getWebsites";

		return Liferay.Service.ajax(params, callback);
	},

	updateWebsite: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateWebsite";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Blogs = {
	servicePackage: "com.liferay.portlet.blogs.service.http."
};

Liferay.Service.Blogs.BlogsCategory = {
	serviceClassName: Liferay.Service.Blogs.servicePackage + "BlogsCategory" + Liferay.Service.classNameSuffix,

	addCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addCategory";

		return Liferay.Service.ajax(params, callback);
	},

	deleteCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteCategory";

		return Liferay.Service.ajax(params, callback);
	},

	getCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCategory";

		return Liferay.Service.ajax(params, callback);
	},

	updateCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateCategory";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Blogs.BlogsEntry = {
	serviceClassName: Liferay.Service.Blogs.servicePackage + "BlogsEntry" + Liferay.Service.classNameSuffix,

	addEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addEntry";

		return Liferay.Service.ajax(params, callback);
	},

	deleteEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getCategoryBlogsRSS: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCategoryBlogsRSS";

		return Liferay.Service.ajax(params, callback);
	},

	getEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getGroupEntries: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getGroupEntries";

		return Liferay.Service.ajax(params, callback);
	},

	getGroupEntriesRSS: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getGroupEntriesRSS";

		return Liferay.Service.ajax(params, callback);
	},

	updateEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Bookmarks = {
	servicePackage: "com.liferay.portlet.bookmarks.service.http."
};

Liferay.Service.Bookmarks.BookmarksEntry = {
	serviceClassName: Liferay.Service.Bookmarks.servicePackage + "BookmarksEntry" + Liferay.Service.classNameSuffix,

	addEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addEntry";

		return Liferay.Service.ajax(params, callback);
	},

	deleteEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEntry";

		return Liferay.Service.ajax(params, callback);
	},

	openEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "openEntry";

		return Liferay.Service.ajax(params, callback);
	},

	updateEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Bookmarks.BookmarksFolder = {
	serviceClassName: Liferay.Service.Bookmarks.servicePackage + "BookmarksFolder" + Liferay.Service.classNameSuffix,

	addFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addFolder";

		return Liferay.Service.ajax(params, callback);
	},

	deleteFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteFolder";

		return Liferay.Service.ajax(params, callback);
	},

	getFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFolder";

		return Liferay.Service.ajax(params, callback);
	},

	updateFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateFolder";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Cal = {
	servicePackage: "com.liferay.portlet.calendar.service.http."
};

Liferay.Service.Cal.CalEvent = {
	serviceClassName: Liferay.Service.Cal.servicePackage + "CalEvent" + Liferay.Service.classNameSuffix,

	addEvent: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addEvent";

		return Liferay.Service.ajax(params, callback);
	},

	deleteEvent: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteEvent";

		return Liferay.Service.ajax(params, callback);
	},

	getEvent: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEvent";

		return Liferay.Service.ajax(params, callback);
	},

	updateEvent: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEvent";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.DL = {
	servicePackage: "com.liferay.portlet.documentlibrary.service.http."
};

Liferay.Service.DL.DLFileEntry = {
	serviceClassName: Liferay.Service.DL.servicePackage + "DLFileEntry" + Liferay.Service.classNameSuffix,

	addFileEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addFileEntry";

		return Liferay.Service.ajax(params, callback);
	},

	deleteFileEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteFileEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getFileEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFileEntry";

		return Liferay.Service.ajax(params, callback);
	},

	lockFileEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "lockFileEntry";

		return Liferay.Service.ajax(params, callback);
	},

	unlockFileEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unlockFileEntry";

		return Liferay.Service.ajax(params, callback);
	},

	updateFileEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateFileEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.DL.DLFileShortcut = {
	serviceClassName: Liferay.Service.DL.servicePackage + "DLFileShortcut" + Liferay.Service.classNameSuffix,

	addFileShortcut: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addFileShortcut";

		return Liferay.Service.ajax(params, callback);
	},

	deleteFileShortcut: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteFileShortcut";

		return Liferay.Service.ajax(params, callback);
	},

	getFileShortcut: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFileShortcut";

		return Liferay.Service.ajax(params, callback);
	},

	updateFileShortcut: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateFileShortcut";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.DL.DLFolder = {
	serviceClassName: Liferay.Service.DL.servicePackage + "DLFolder" + Liferay.Service.classNameSuffix,

	addFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addFolder";

		return Liferay.Service.ajax(params, callback);
	},

	deleteFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteFolder";

		return Liferay.Service.ajax(params, callback);
	},

	getFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFolder";

		return Liferay.Service.ajax(params, callback);
	},

	updateFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateFolder";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.IG = {
	servicePackage: "com.liferay.portlet.imagegallery.service.http."
};

Liferay.Service.IG.IGFolder = {
	serviceClassName: Liferay.Service.IG.servicePackage + "IGFolder" + Liferay.Service.classNameSuffix,

	addFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addFolder";

		return Liferay.Service.ajax(params, callback);
	},

	deleteFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteFolder";

		return Liferay.Service.ajax(params, callback);
	},

	getFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFolder";

		return Liferay.Service.ajax(params, callback);
	},

	updateFolder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateFolder";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.IG.IGImage = {
	serviceClassName: Liferay.Service.IG.servicePackage + "IGImage" + Liferay.Service.classNameSuffix,

	deleteImage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteImage";

		return Liferay.Service.ajax(params, callback);
	},

	getImage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getImage";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Journal = {
	servicePackage: "com.liferay.portlet.journal.service.http."
};

Liferay.Service.Journal.JournalArticle = {
	serviceClassName: Liferay.Service.Journal.servicePackage + "JournalArticle" + Liferay.Service.classNameSuffix,

	getArticle: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getArticle";

		return Liferay.Service.ajax(params, callback);
	},

	removeArticleLocale: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "removeArticleLocale";

		return Liferay.Service.ajax(params, callback);
	},

	updateContent: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateContent";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Journal.JournalStructure = {
	serviceClassName: Liferay.Service.Journal.servicePackage + "JournalStructure" + Liferay.Service.classNameSuffix,

	addStructure: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addStructure";

		return Liferay.Service.ajax(params, callback);
	},

	deleteStructure: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteStructure";

		return Liferay.Service.ajax(params, callback);
	},

	getStructure: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getStructure";

		return Liferay.Service.ajax(params, callback);
	},

	updateStructure: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateStructure";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Journal.JournalTemplate = {
	serviceClassName: Liferay.Service.Journal.servicePackage + "JournalTemplate" + Liferay.Service.classNameSuffix,

	deleteTemplate: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteTemplate";

		return Liferay.Service.ajax(params, callback);
	},

	getTemplate: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getTemplate";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.MB = {
	servicePackage: "com.liferay.portlet.messageboards.service.http."
};

Liferay.Service.MB.MBBan = {
	serviceClassName: Liferay.Service.MB.servicePackage + "MBBan" + Liferay.Service.classNameSuffix,

	addBan: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addBan";

		return Liferay.Service.ajax(params, callback);
	},

	deleteBan: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteBan";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.MB.MBCategory = {
	serviceClassName: Liferay.Service.MB.servicePackage + "MBCategory" + Liferay.Service.classNameSuffix,

	addCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addCategory";

		return Liferay.Service.ajax(params, callback);
	},

	deleteCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteCategory";

		return Liferay.Service.ajax(params, callback);
	},

	getCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCategory";

		return Liferay.Service.ajax(params, callback);
	},

	subscribeCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "subscribeCategory";

		return Liferay.Service.ajax(params, callback);
	},

	unsubscribeCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsubscribeCategory";

		return Liferay.Service.ajax(params, callback);
	},

	updateCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateCategory";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.MB.MBMessage = {
	serviceClassName: Liferay.Service.MB.servicePackage + "MBMessage" + Liferay.Service.classNameSuffix,

	addDiscussionMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addDiscussionMessage";

		return Liferay.Service.ajax(params, callback);
	},

	addMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addMessage";

		return Liferay.Service.ajax(params, callback);
	},

	deleteDiscussionMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteDiscussionMessage";

		return Liferay.Service.ajax(params, callback);
	},

	deleteMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteMessage";

		return Liferay.Service.ajax(params, callback);
	},

	getMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getMessage";

		return Liferay.Service.ajax(params, callback);
	},

	getMessageDisplay: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getMessageDisplay";

		return Liferay.Service.ajax(params, callback);
	},

	subscribeMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "subscribeMessage";

		return Liferay.Service.ajax(params, callback);
	},

	unsubscribeMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "unsubscribeMessage";

		return Liferay.Service.ajax(params, callback);
	},

	updateDiscussionMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateDiscussionMessage";

		return Liferay.Service.ajax(params, callback);
	},

	updateMessage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateMessage";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Polls = {
	servicePackage: "com.liferay.portlet.polls.service.http."
};

Liferay.Service.Polls.PollsQuestion = {
	serviceClassName: Liferay.Service.Polls.servicePackage + "PollsQuestion" + Liferay.Service.classNameSuffix,

	addQuestion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addQuestion";

		return Liferay.Service.ajax(params, callback);
	},

	deleteQuestion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteQuestion";

		return Liferay.Service.ajax(params, callback);
	},

	getQuestion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getQuestion";

		return Liferay.Service.ajax(params, callback);
	},

	updateQuestion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateQuestion";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Polls.PollsVote = {
	serviceClassName: Liferay.Service.Polls.servicePackage + "PollsVote" + Liferay.Service.classNameSuffix,

	addVote: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addVote";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Ratings = {
	servicePackage: "com.liferay.portlet.ratings.service.http."
};

Liferay.Service.Ratings.RatingsEntry = {
	serviceClassName: Liferay.Service.Ratings.servicePackage + "RatingsEntry" + Liferay.Service.classNameSuffix,

	updateEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Shopping = {
	servicePackage: "com.liferay.portlet.shopping.service.http."
};

Liferay.Service.Shopping.ShoppingCategory = {
	serviceClassName: Liferay.Service.Shopping.servicePackage + "ShoppingCategory" + Liferay.Service.classNameSuffix,

	addCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addCategory";

		return Liferay.Service.ajax(params, callback);
	},

	deleteCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteCategory";

		return Liferay.Service.ajax(params, callback);
	},

	getCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCategory";

		return Liferay.Service.ajax(params, callback);
	},

	updateCategory: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateCategory";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Shopping.ShoppingCoupon = {
	serviceClassName: Liferay.Service.Shopping.servicePackage + "ShoppingCoupon" + Liferay.Service.classNameSuffix,

	addCoupon: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addCoupon";

		return Liferay.Service.ajax(params, callback);
	},

	deleteCoupon: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteCoupon";

		return Liferay.Service.ajax(params, callback);
	},

	getCoupon: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCoupon";

		return Liferay.Service.ajax(params, callback);
	},

	search: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "search";

		return Liferay.Service.ajax(params, callback);
	},

	updateCoupon: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateCoupon";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Shopping.ShoppingItem = {
	serviceClassName: Liferay.Service.Shopping.servicePackage + "ShoppingItem" + Liferay.Service.classNameSuffix,

	addBookItems: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addBookItems";

		return Liferay.Service.ajax(params, callback);
	},

	deleteItem: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteItem";

		return Liferay.Service.ajax(params, callback);
	},

	getItem: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getItem";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Shopping.ShoppingOrder = {
	serviceClassName: Liferay.Service.Shopping.servicePackage + "ShoppingOrder" + Liferay.Service.classNameSuffix,

	completeOrder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "completeOrder";

		return Liferay.Service.ajax(params, callback);
	},

	deleteOrder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteOrder";

		return Liferay.Service.ajax(params, callback);
	},

	getOrder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getOrder";

		return Liferay.Service.ajax(params, callback);
	},

	sendEmail: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "sendEmail";

		return Liferay.Service.ajax(params, callback);
	},

	updateOrder: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateOrder";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.SC = {
	servicePackage: "com.liferay.portlet.softwarecatalog.service.http."
};

Liferay.Service.SC.SCLicense = {
	serviceClassName: Liferay.Service.SC.servicePackage + "SCLicense" + Liferay.Service.classNameSuffix,

	addLicense: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addLicense";

		return Liferay.Service.ajax(params, callback);
	},

	deleteLicense: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteLicense";

		return Liferay.Service.ajax(params, callback);
	},

	getLicense: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getLicense";

		return Liferay.Service.ajax(params, callback);
	},

	updateLicense: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateLicense";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.SC.SCFrameworkVersion = {
	serviceClassName: Liferay.Service.SC.servicePackage + "SCFrameworkVersion" + Liferay.Service.classNameSuffix,

	addFrameworkVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addFrameworkVersion";

		return Liferay.Service.ajax(params, callback);
	},

	deleteFrameworkVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteFrameworkVersion";

		return Liferay.Service.ajax(params, callback);
	},

	getFrameworkVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFrameworkVersion";

		return Liferay.Service.ajax(params, callback);
	},

	getFrameworkVersions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getFrameworkVersions";

		return Liferay.Service.ajax(params, callback);
	},

	updateFrameworkVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateFrameworkVersion";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.SC.SCProductEntry = {
	serviceClassName: Liferay.Service.SC.servicePackage + "SCProductEntry" + Liferay.Service.classNameSuffix,

	addProductEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addProductEntry";

		return Liferay.Service.ajax(params, callback);
	},

	deleteProductEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteProductEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getProductEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getProductEntry";

		return Liferay.Service.ajax(params, callback);
	},

	updateProductEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateProductEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.SC.SCProductVersion = {
	serviceClassName: Liferay.Service.SC.servicePackage + "SCProductVersion" + Liferay.Service.classNameSuffix,

	addProductVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addProductVersion";

		return Liferay.Service.ajax(params, callback);
	},

	deleteProductVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteProductVersion";

		return Liferay.Service.ajax(params, callback);
	},

	getProductVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getProductVersion";

		return Liferay.Service.ajax(params, callback);
	},

	getProductVersions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getProductVersions";

		return Liferay.Service.ajax(params, callback);
	},

	getProductVersionsCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getProductVersionsCount";

		return Liferay.Service.ajax(params, callback);
	},

	updateProductVersion: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateProductVersion";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Tags = {
	servicePackage: "com.liferay.portlet.tags.service.http."
};

Liferay.Service.Tags.TagsAsset = {
	serviceClassName: Liferay.Service.Tags.servicePackage + "TagsAsset" + Liferay.Service.classNameSuffix,

	deleteAsset: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteAsset";

		return Liferay.Service.ajax(params, callback);
	},

	getAsset: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getAsset";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Tags.TagsEntry = {
	serviceClassName: Liferay.Service.Tags.servicePackage + "TagsEntry" + Liferay.Service.classNameSuffix,

	addEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addEntry";

		return Liferay.Service.ajax(params, callback);
	},

	deleteEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getEntries: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEntries";

		return Liferay.Service.ajax(params, callback);
	},

	search: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "search";

		return Liferay.Service.ajax(params, callback);
	},

	searchAutocomplete: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "searchAutocomplete";

		return Liferay.Service.ajax(params, callback);
	},

	searchCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "searchCount";

		return Liferay.Service.ajax(params, callback);
	},

	updateEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Tags.GN_KMS_MetaTagsEntry = {
	serviceClassName: Liferay.Service.Tags.servicePackage + "TagsEntry" + Liferay.Service.classNameSuffix,

	addEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addEntry";

		return Liferay.Service.ajax(params, callback);
	},

	deleteEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteEntry";

		return Liferay.Service.ajax(params, callback);
	},

	getEntries: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getEntries";

		return Liferay.Service.ajax(params, callback);
	},

	search: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "search";

		return Liferay.Service.ajax(params, callback);
	},

	searchAutocomplete: function(params, callback) {
		params.serviceClassName = "com.ext.portlet.cms.kms.MetaDataUtil";
		params.serviceMethodName = "searchAutocomplete";

		return Liferay.Service.ajax(params, callback);
	},

	lookupAutocomplete: function(params, callback) {
		params.serviceClassName = "com.ext.portlet.cms.kms.MetaDataUtil";
		params.serviceMethodName = "lookupAutocomplete";

		return Liferay.Service.ajax(params, callback);
	},
	
	searchCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "searchCount";

		return Liferay.Service.ajax(params, callback);
	},

	updateEntry: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateEntry";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Tags.TagsProperty = {
	serviceClassName: Liferay.Service.Tags.servicePackage + "TagsProperty" + Liferay.Service.classNameSuffix,

	addProperty: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addProperty";

		return Liferay.Service.ajax(params, callback);
	},

	deleteProperty: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteProperty";

		return Liferay.Service.ajax(params, callback);
	},

	getProperties: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getProperties";

		return Liferay.Service.ajax(params, callback);
	},

	getPropertyValues: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getPropertyValues";

		return Liferay.Service.ajax(params, callback);
	},

	updateProperty: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateProperty";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Wiki = {
	servicePackage: "com.liferay.portlet.wiki.service.http."
};

Liferay.Service.Wiki.WikiNode = {
	serviceClassName: Liferay.Service.Wiki.servicePackage + "WikiNode" + Liferay.Service.classNameSuffix,

	addNode: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addNode";

		return Liferay.Service.ajax(params, callback);
	},

	deleteNode: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deleteNode";

		return Liferay.Service.ajax(params, callback);
	},

	getNode: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getNode";

		return Liferay.Service.ajax(params, callback);
	},

	updateNode: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updateNode";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Wiki.WikiPage = {
	serviceClassName: Liferay.Service.Wiki.servicePackage + "WikiPage" + Liferay.Service.classNameSuffix,

	addPage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addPage";

		return Liferay.Service.ajax(params, callback);
	},

	deletePage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deletePage";

		return Liferay.Service.ajax(params, callback);
	},

	getPage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getPage";

		return Liferay.Service.ajax(params, callback);
	},

	revertPage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "revertPage";

		return Liferay.Service.ajax(params, callback);
	},

	updatePage: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "updatePage";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Workflow = {
	servicePackage: "com.liferay.portlet.workflow.service.http."
};

Liferay.Service.Workflow.WorkflowComponent = {
	serviceClassName: Liferay.Service.Workflow.servicePackage + "WorkflowComponent" + Liferay.Service.classNameSuffix,

	getCurrentTasks: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCurrentTasks";

		return Liferay.Service.ajax(params, callback);
	},

	getCurrentTasksXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getCurrentTasksXml";

		return Liferay.Service.ajax(params, callback);
	},

	deploy: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "deploy";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinition: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinition";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinitions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinitions";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinitionsXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinitionsXml";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinitionsCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinitionsCount";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinitionsCountXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinitionsCountXml";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinitionXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinitionXml";

		return Liferay.Service.ajax(params, callback);
	},

	getInstances: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getInstances";

		return Liferay.Service.ajax(params, callback);
	},

	getInstancesCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getInstancesCount";

		return Liferay.Service.ajax(params, callback);
	},

	getInstancesCountXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getInstancesCountXml";

		return Liferay.Service.ajax(params, callback);
	},

	getInstancesXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getInstancesXml";

		return Liferay.Service.ajax(params, callback);
	},

	getTaskFormElements: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getTaskFormElements";

		return Liferay.Service.ajax(params, callback);
	},

	getTaskFormElementsXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getTaskFormElementsXml";

		return Liferay.Service.ajax(params, callback);
	},

	getTaskTransitions: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getTaskTransitions";

		return Liferay.Service.ajax(params, callback);
	},

	getTaskTransitionsXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getTaskTransitionsXml";

		return Liferay.Service.ajax(params, callback);
	},

	getUserTasks: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserTasks";

		return Liferay.Service.ajax(params, callback);
	},

	getUserTasksCount: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserTasksCount";

		return Liferay.Service.ajax(params, callback);
	},

	getUserTasksCountXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserTasksCountXml";

		return Liferay.Service.ajax(params, callback);
	},

	getUserTasksXml: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getUserTasksXml";

		return Liferay.Service.ajax(params, callback);
	},

	signalInstance: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "signalInstance";

		return Liferay.Service.ajax(params, callback);
	},

	signalToken: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "signalToken";

		return Liferay.Service.ajax(params, callback);
	},

	startWorkflow: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "startWorkflow";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Workflow.WorkflowDefinition = {
	serviceClassName: Liferay.Service.Workflow.servicePackage + "WorkflowDefinition" + Liferay.Service.classNameSuffix,

	addDefinition: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addDefinition";

		return Liferay.Service.ajax(params, callback);
	},

	getDefinition: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "getDefinition";

		return Liferay.Service.ajax(params, callback);
	}
};

Liferay.Service.Workflow.WorkflowInstance = {
	serviceClassName: Liferay.Service.Workflow.servicePackage + "WorkflowInstance" + Liferay.Service.classNameSuffix,

	addInstance: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "addInstance";

		return Liferay.Service.ajax(params, callback);
	},

	signalInstance: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "signalInstance";

		return Liferay.Service.ajax(params, callback);
	},

	signalToken: function(params, callback) {
		params.serviceClassName = this.serviceClassName;
		params.serviceMethodName = "signalToken";

		return Liferay.Service.ajax(params, callback);
	}
};
// file seperator

Liferay.autoFields = new Class({
	/*
	Options
	html (String) HTML to append to the end of the container
	container (String) the jQuery selector of the item(s) you wish to append the HTML to
	addText (String) the text you wish to use for the "Add" link
	removeText (String) the text you wish to use for the "Remove" link
	clearText (String) the text you wish to use for the "Clear" link (this link clears all of the added forms except the very first one, a sort of reset button)
	confirmText (String) the text you wish to use to confirm that the user wishes to clear all of the added buttons (leave empty to not confirm)
	rowType (String) the html tag for the row of fields (eg. fieldset, div or tr)
	onAdd (function) a callback that executes after new fields have been added
	onRemove (function) a callback that executes after fields have been removed
	onClear (function) a callback that executes after the form fields have been returned
	init (function) a callback that executes after the class has fully initialized
	*/
	initialize: function(options) {
		var instance = this;

		options = jQuery.extend(options, {});

		instance._html = jQuery(options.html || '');
		instance._container = jQuery(options.container || '');
		instance._addText = options.addText || '';
		instance._removeText = options.removeText || '';
		instance._clearText = options.clearText || '';
		instance._confirmText = options.confirmText || '';
		instance._rowType = options.rowType || '';
		instance._onAdd = options.onAdd;
		instance._onRemove = options.onRemove;
		instance._onClear = options.onClear;
		instance._init = options.init || false;

		instance._numField = 1;

		instance._run();

		if (instance._init) {
			instance._init();
		}
	},

	_run: function() {
		var instance = this;

		var container = instance._container;

		if (container.length) {
			var html = instance._html;

			var addLink, removeLink, clearLink;
			var links = jQuery('<span class="lfr-control-links"></span>');

			if (instance._addText) {
				addLink = jQuery('<a href="javascript:;">' + instance._addText + '</a>');

				addLink.click(
				   function() {
					   var newField = instance._addFields();
					   if (instance._onAdd) {
							   instance._onAdd(newField);
					   }
				   }
				);

				links.append(addLink);
			}

			if (instance._removeText) {
				removeLink = jQuery('<a href="javascript:;">' + instance._removeText + '</a>');

				removeLink.hide();

				removeLink.click(
				   function() {
					   instance._removeFields();
					   if (instance._onRemove) {
							   instance._onRemove();
					   }
				   }
				);

				links.append(removeLink);
			}

			if (instance._clearText) {
				clearLink = jQuery('<a href="javascript:;">' + instance._clearText + '</a>');

				clearLink.click(
				   function() {
					   instance._clearFields();
					   if (instance._onClear) {
							   instance._onClear();
					   }
				   }
				);

				links.append(clearLink);
			}

			container.after(links);
			instance._controlLinks = links;
		}
	},

	_addFields: function() {
		var instance = this;

		var container = instance._container;
		var html = instance._html.clone();

		container.append(html);

		instance._numField++;

		var removeLink = instance._controlLinks.find('a:eq(1)');

		if (removeLink.is(':hidden')) {
			removeLink.show();
		}

		return html;
	},

	_clearFields: function() {
		var instance = this;

		var container = instance._container;
		var rows = container.find(instance._rowType).not(':first');

		var confirmBox = true;

		if (instance._confirmText) {
			   confirmBox = confirm(instance._confirmText);
		}

		if (confirmBox) {
			   rows.remove();
			   instance._numField = 1;
		}
	},

	_removeFields: function() {
		var instance = this;

		var container = instance._container;
		var lastRow = container.find(instance._rowType + ':last');

		if (instance._numField > 1) {
			   lastRow.remove();
			   --instance._numField;
		}

		if (instance._numField <= 1) {
		   var removeLink = instance._controlLinks.find('a:eq(1)');

		   if (removeLink.is(':visible')) {
				   removeLink.hide();
		   }
		}
	}
});
// file seperator

Liferay.ColorPicker = new Class({

	/*
	context (Object): A DOM object which specifies the context in which to search for the item
	hasImage: (Boolean) If set to true, it uses the "item" param or whatever image has the .use-color-picker class as the image
	item: (Object|String): A DOM object or a jQuery Selector string that specifies which field to insert the selected value into
	onChange (Function): A function that will get called whenever the color changes
	onClose (Function): A function that will get called when the color picker is closed
	*/
	initialize: function(params) {
		var instance = this;

		params = params || {};

		instance._onClose = params.onClose || null;
		instance._onChange = params.onChange || null;
		instance._context = params.context || document.body;
		instance._hasImage = params.hasImage || false;
		instance._item = jQuery(params.item || '.use-color-picker', instance._context);

		instance._baseColor = {r:255, g:0, b:0};
		instance._currentColor = {r:255, g:255, b:255};
		instance._lastValues = [0,0];

		instance._insertImages();

		instance._buildHTML();

		instance._activatePicker();
	},

	_activatePicker: function() {
		var instance = this;

		var currentColor = instance._currentColor;

		var onChange = function() {
			var r = instance._currentColor.r;
			var g = instance._currentColor.g;
			var b = instance._currentColor.b;

			var backgroundColor = 'rgb(' + r + ', ' + g + ', ' + b + ')';

			instance._baseDiv.find('.lfr-old-color').css('background-color', backgroundColor);

			if (instance._onChange) {
				instance._onChange(instance._currentColor);
			}
		};

		instance._baseDiv.find('.lfr-color').Slider(
			{
				accept : '.lfr-color-indic',
				onSlide : function(cordx, cordy, x, y) {
					instance._lastValues = [parseInt(cordx * 255 / 100), parseInt(cordy * 255 / 100)];
					instance._setGradientColor();
				},
				onChange : onChange
			}
		);

		instance._baseDiv.find('.lfr-hue').Slider(
			{
				accept : '.lfr-hue-indic',
				onSlide : function( cordx, cordy,x, y) {
					instance._setVertColor(parseInt(cordy * 255 / 100));
					instance._setGradientColor();
				},
				onChange : onChange
			}
		);
	},

	_buildHTML: function() {
		var instance = this;

		var baseDiv = jQuery('<div class="lfr-color-picker"></div>');
		var color = jQuery('<div class="lfr-color"><div class="lfr-color-indic"></div></div>');
		var hue = jQuery('<div class="lfr-hue"><div class="lfr-hue-indic"></div></div>');
		var currentColor = jQuery('<div class="lfr-current-color"><div class="lfr-old-color"></div></div>');
		var closeButton = jQuery('<div class="lfr-color-picker-close">X</div>');

		closeButton.click(
			function(event) {
				instance._toggle(event, this);
			}
		);

		baseDiv.append(color).append(hue).append(currentColor).append(closeButton);

		baseDiv.appendTo('body');

		baseDiv.hide();

		baseDiv.css(
			{
				position: 'absolute',
				zIndex: Liferay.zIndex.ALERT + 1
			}
		);

		instance._baseDiv = baseDiv;
	},

	_insertImages: function() {
		var instance = this;

		var context = instance._context;

		var items = instance._item;

		var colorPickerImgHTML = '<img class="lfr-color-picker-img" src="' + themeDisplay.getPathThemeImages() + '/color_picker/color_picker.png" />';

		if (items.length == 1) {
			var colorPickerImg;

			if (instance._hasImage) {
				colorPickerImg = items;
			}
			else {
				colorPickerImg = jQuery(colorPickerImgHTML);

				items.after(colorPickerImg);
			}

			colorPickerImg.click(
				function(event) {
					instance._toggle(event, this);
				}
			);
		}
		else {
			items.each(
				function() {
					var item = jQuery(this);
					var colorPickerImg;

					if (!instance._hasImage) {
						colorPickerImg = jQuery(colorPickerImgHTML);
					}
					else {
						colorPickerImg = item;
					}

					colorPickerImg.click(
						function(event) {
							instance._toggle(event, this);
						}
					);

					item.after(colorPickerImg);
				}
			);
		}
	},

	_setVertColor: function(indic) {
		var instance = this;

		var num = 256 / 6;
		var num2 = 256 / num;
		var color = indic;
		var color2 = color % num;

		var red = 255;
		var green = 255 - color2 * num2;
		var blue = 0;

		if (color < (num * 5)) {
			red = color2 * num2;
			green = 255;

			if (color < (num * 4)) {
				red = 0;
				blue = 255 - color2 * num2;

				if (color < (num * 3)) {
					green = color2 * num2;
					blue = 255;

					if (color < (num * 2)) {
						red = 255 - color2 * num2;
						green = 0;

						if (color < num) {
							red = 255;
							blue = color2 * num2;
						}
					}
				}
			}
		}

		instance._baseColor = {
			r: parseInt(red),
			g: parseInt(green),
			b: parseInt(blue)
		};

		instance._baseDiv.find('.lfr-color').css('background-color', 'rgb(' + instance._baseColor.r + ', ' + instance._baseColor.g + ', ' + instance._baseColor.b + ')');
	},

	_setGradientColor: function() {
		var instance = this;

		var baseColor = instance._baseColor;
		var lastValues = instance._lastValues;

		var r = instance._toBase(baseColor.r);
		var g = instance._toBase(baseColor.g);
		var b = instance._toBase(baseColor.b);

		var rX = instance._toHex(r);
		var gX = instance._toHex(g);
		var bX = instance._toHex(b);

		instance._baseDiv.find('.lfr-current-color').css('background-color', 'rgb(' + r + ', ' + g + ', ' + b + ')');

		instance._hexColor = '#' + (rX + gX + bX).toUpperCase();

		instance._currentInput.val(instance._hexColor);

		instance._currentColor = {r: r, g: g, b: b};
	},

	_toggle: function(event, obj) {
		var instance = this;

		var item = jQuery(obj);

		var dimensions = item.offset();

		instance._currentInput = item.prev();

		var baseDiv = instance._baseDiv;

		if (baseDiv.is(':visible')) {
			baseDiv.hide();

			if (instance._item.is('input')) {
				instance._item.trigger('blur');
			}

			if (instance._onClose) {
				instance._onClose();
			}
		}
		else {
			baseDiv.show();

			if (instance._item.is('input')) {
				instance._item.trigger('focus');
			}

			baseDiv.css(
				{
					top: dimensions.top + 'px',
					left: dimensions.left + 25 + 'px'
				}
			);
		}
	},

	_toBase: function(colorVal) {
		var instance = this;

		var lastValues = instance._lastValues;

		return Math.round((1 - (1 - (colorVal / 255)) * (lastValues[0] / 255)) * (255 - lastValues[1]));
	},

	_toHex: function(color) {
		var instance = this;

		color = parseInt(color).toString(16);

		if (color.length < 2) {
			return "0" + color;
		}
		else {
			return color;
		}
	},

	_toRGB: function(color) {
		var instance = this;

		color = color.replace('#', '');

		if (color.length == 6 || color.length == 3) {
			var r, g, b;

			if (color.length == 6) {
				r = color.substring(0, 2);
				g = color.substring(2, 4);
				b = color.substring(4, 6);
			}
			else if (color.length == 3) {
				r = color.substring(0, 1);
				g = color.substring(1, 2);
				b = color.substring(2, 3);

				r = r + r;
				g = g + g;
				b = b + b;
			}

			r = parseInt(r, 16);
			g = parseInt(g, 16);
			b = parseInt(b, 16);

			return {r: r, g: g, b: b};
		}

		return null;
	}
});
// file seperator

(function(lib){
	lib.Columns = function(options) {
		lib.Columns.init(options);
	};

	lib.Columns.extendNativeFunctionObject({

		init: function(options) {
			var instance = this;

			// Set private variables
			instance._columns = options.columnSelector;
			instance._dropPosition = options.positionClass;
			instance._dropArea = options.areaClass;
			instance._handle = options.handleSelector;
			instance._onDrop = options.onComplete;
			instance._portlets = options.boxSelector;
			instance._cache = {};

			jQuery(instance._columns).find(instance._portlets).each(function() {
				var portlet = this;

				if (!portlet.isStatic) {
					instance.add(portlet);
				}
			});
		},

		add: function(portlet) {
			var instance = this;
			var jPortlet = jQuery(portlet);
			var jHandle = jPortlet.find(instance._handle);

			jHandle.css({cursor: "move"});
			jPortlet.css({position: "relative"});

			jPortlet.lDrag({
				clone: true,
				dragClass: "drag-indicator",
				handle: jPortlet.find(instance._handle)[0],
				onMove: function(s){instance._onMove(s)},
				onComplete: function(s){instance._onComplete(s);},
				threshold: 2,
				scroll: true
			});
		},

		_clearCache: function() {
			if (this._cache.dropArea) {
				jQuery(this._cache.dropArea).remove();
			}
			if (this._cache.dropPosition) {
				jQuery(this._cache.dropPosition).remove();
			}
			this._cache = {};
		},

		_findContainer: function(coord) {
			var instance = this;
			var jColumns = instance._cache.columns;

			if (!jColumns) {
				jQuery(".lfr-column").addClass("dragging");

				jColumns = instance._cache.columns = jQuery(instance._columns);
				instance._cache.columnData = [];

				jColumns.each(function(i){
					var element = this.parentNode;
					instance._cache.columnData[i] = jQuery(element).coordinatesData(true);
				});
			}

			var data, quadrant, rt = null;

			jColumns.each(function(i) {

				quadrant = coord.insideObjectData(instance._cache.columnData[i]);

				if (quadrant) {
					data = instance._cache.columnData[i];
					data.quadrant = quadrant;
					rt = this;
					return false;
				}
			});

			return rt ? {area: rt, data: data} : null;
		},

		_findPortlet: function(coord, scope, current) {
			var instance = this;

			if (!instance._cache.portlets) {
				instance._cache.portlets = [];
				instance._cache.portletData = [];
				instance._cache.portletList = [];
			}

			var jPortlets = instance._cache.portlets[scope.id];

			if (!jPortlets) {
				jPortlets = jQuery(instance._portlets, scope);
				instance._cache.portlets[scope.id] = jPortlets;
				instance._cache.portletData[scope.id] = [];
				instance._cache.portletList[scope.id] = new LinkedList();

				jPortlets.each(function(i){
					instance._cache.portletData[scope.id][i] = jQuery(this).coordinatesData(true);
					instance._cache.portletList[scope.id].add(this);
				});
			}

			var data, quadrant, rt = null;

			jPortlets.each(function(i) {
				data = instance._cache.portletData[scope.id][i];
				quadrant = coord.insideObjectData(data);

				if (quadrant) {
					data.quadrant = quadrant;
					rt = this;
					return false;
				}
				else if (coord.y < data.midPoint.y) {
					data.quadrant = 1;
					rt = this;
					return false;
				}
				else if (i == jPortlets.length - 1) {
					data.quadrant = 4;
					rt = this;
					return false;
				}
			});

			return rt ? {position: rt, data: data} : null;
		},

		_showArea: function(container, nwOffset) {
			instance = this;
			var dropArea = instance._cache.dropArea;

			if (!dropArea) {
				jQuery("body:first").append("<div class='" + instance._dropArea + "'></div>");
				instance._cache.dropArea = dropArea = jQuery("." + instance._dropArea + ":first");
				dropArea.css({
					position: "absolute",
					zIndex: Liferay.zIndex.DROP_AREA
				});
			}

			var element = jQuery(container.parentNode.nodeName.toLowerCase() == "td" ? container.parentNode : container.parentNode);
			dropArea.css({
				display: "",
				height: element.height(),
				left: nwOffset.x,
				top: nwOffset.y,
				width: element.width()
			});
		},

		_showPosition: function(portlet, nwOffset, quadrant) {
			instance = this;
			var dropPos = instance._cache.dropPosition;

			if (!dropPos) {
				jQuery("body:first").append("<div class='" + instance._dropPosition + "'></div>");
				dropPos = jQuery("." + instance._dropPosition + ":first");

				dropPos[0].style.position = 'absolute';
				dropPos[0].style.zIndex = Liferay.zIndex.DROP_POSITION;

				instance._cache.dropPosition = dropPos;
			}
			var jDropPos = jQuery(instance._cache.dropPosition);
			var jPortlet = jQuery(portlet);
			var portletWidth = jPortlet.width();
			var portletHeight = jPortlet.height();

			dropPos.css({
				display: "",
				height: portletHeight / 2,
				left: nwOffset.x + "px",
				width: portletWidth + "px"
			});

			if (quadrant == 1 || quadrant == 2) {
				dropPos.css({ top: nwOffset.y + "px" });
				if (dropPos[0].className != "drop-position-top") {
					dropPos[0].className = "drop-position-top";
				}
			}
			else {
				dropPos.css({ top: (nwOffset.y + portletHeight / 2) + "px" });
				if (dropPos[0].className != "drop-position-bottom") {
					dropPos[0].className = "drop-position-bottom";
				}
			}
		},

		_hideArea: function() {
			if (this._cache.dropArea) {
				this._cache.dropArea.css({display: "none"});
			}
		},

		_hidePosition: function() {
			if (this._cache.dropPosition) {
				this._cache.dropPosition.css({display: "none"});
			}
		},

		_hasMoved: function(current, position, quadrant) {
			var instance = this;
			var rt = true;

			if (current == position) {
				rt = false;
			}
			else {
				var portlets = instance._cache.portletList[current.parentNode.id];

				if (portlets) {
					portlets.each(function(item) {
						if (item == position) {
							if ((quadrant == 1 || quadrant == 2) && item.listInfo.prev == current) {
								rt = false;
							}
							else if ((quadrant == 3 || quadrant == 4) && item.listInfo.next == current) {
								rt = false;
							}
						}
					});
				}
			}

			return rt;
		},

		_onMove: function(settings) {
			settings.container.style.top = 0;
			settings.container.style.left = 0;
			var instance = this;
			var foundContainer = instance._findContainer(mousePos);
			var foundPortlet = null;

			if (foundContainer) {
				foundPortlet = instance._findPortlet(mousePos, foundContainer.area, settings.container);
				instance._showArea(foundContainer.area, foundContainer.data.nwOffset);

				if (foundPortlet && foundPortlet.position.isStatic) {
					foundPortlet = null;
				}
			}
			else {
				instance._hideArea();
			}

			if (foundPortlet && settings.container != foundPortlet.position) {
				var cPortlet = foundPortlet.position;
				var data = foundPortlet.data;
				instance._showPosition(cPortlet, data.nwOffset, data.quadrant);
			}
			else {
				instance._hidePosition();
			}
		},

		_onComplete: function(settings) {
			jQuery(settings.container).css({top: 0, left: 0});
			var instance = this;
			var foundContainer = instance._findContainer(mousePos);

			instance._hidePosition();
			instance._hideArea();

			if (instance._onDrop && foundContainer) {
				var foundPortlet = instance._findPortlet(mousePos, foundContainer.area, settings.container);

				if (foundPortlet) {
					if (instance._hasMoved(settings.container, foundPortlet.position, foundPortlet.data.quadrant) && !foundPortlet.position.isStatic) {
						// Move if not in the same position
						instance._onDrop({
							portlet: settings.container,
							neighbor: foundPortlet.position,
							quadrant: foundPortlet.data.quadrant
						});
					}
				}
				else {
					// Add portlet to empty column
					instance._onDrop({
						portlet: settings.container,
						container: foundContainer.area
					});
				}
			}

			jQuery(".lfr-column").removeClass("dragging");
			instance._clearCache();
		}
	});
})(Liferay);

// file seperator

Liferay.Dock = {
	init: function() {
		var instance = this;

		var dock = jQuery('.lfr-dock');

		if (!dock.is('.interactive-mode')) {
			return;
		}

		var dockList = dock.find('.lfr-dock-list');

		if (dockList.length > 0){
			var myPlaces = jQuery('.my-places', dock);

			instance._dock = dock;
			instance._dockList = dockList;
			instance._myPlaces = myPlaces;

			instance._hideCommunities(myPlaces);

			dockList.hide();
			dockList.wrap('<div class="lfr-dock-list-container"></div>');

			var dockData = {
				dock: dock,
				dockList: dockList
			};

			dock.css(
				{
					cursor: 'pointer',
					position: 'absolute',
					zIndex: Liferay.zIndex.DOCK
				}
			);

			var dockOver = function(event) {
				event.data = dockData;

				jQuery(document).one(
					'click',
					function(internalEvent) {
						var currentEl = jQuery(internalEvent.target);
						var dockParent = currentEl.parents('.lfr-dock');

						if ((dockParent.length == 0) && !currentEl.is('.lfr-dock')) {
							instance._toggle(event, 'hide');
						}
					}
				);

				instance._toggle(event, 'show');
			};

			var dockOut = function(event) {
				event.data = dockData;

				instance._toggle(event, 'hide');
			};

			var myPlacesToggle = function(event) {
				event.data = myPlaces;

				instance._togglePlaces(event);
			};

			dock.hoverIntent(
				{
					interval: 0,
					out: dockOut,
					over: dockOver,
					timeout: 500
				}
			);

			myPlaces.hoverIntent(
				{
					interval: 0,
					out: myPlacesToggle,
					over: myPlacesToggle,
					timeout: 250
				}
			);

			myPlaces.find('.my-places-toggle, a[href=javascript: ;]').click(
				function() {
					return false;
				}
			);

			var dockParent = dock.parent();

			dockParent.css(
				{
					position: 'relative',
					zIndex: Liferay.zIndex.DOCK_PARENT
				}
			);

			instance._handleDebug();
		}
	},

	_handleDebug: function() {
		var instance = this;

		var dock = instance._dock;
		var dockList = instance._dockList;
		var myPlacesList = instance._myPlaces.find('> ul');

		if (dock.is('.debug')) {
			dock.show();
			dockList.show();
			dockList.addClass('expanded');
			myPlacesList.addClass('show-my-places');
		}
	},

	_hideCommunities: function(jQueryObj) {
		var myPlaces = jQueryObj;

		var communities = myPlaces.find('> ul > li');
		var communityList = communities.find('ul');
		var currentCommunity = communityList.find('li.current');
		var heading = communities.find('h3');

		heading.wrap('<div class="my-places-toggle"></div>');

		heading = heading.parent();

		communityList.hide();
		currentCommunity.parent().show();

		var currentCommunityHeading = currentCommunity.parent().prev();

		currentCommunityHeading.addClass('hide');

		heading.click(
			function() {
				var heading = jQuery(this);

				heading.next("ul").BlindToggleVertically("fast");
				heading.toggleClass('hide');
			}
		);
	},

	_toggle: function(event, state) {
		var params = event.data;

		var dock = params.dock;
		var dockList = params.dockList;

		if (state == 'hide') {
			dockList.hide();
			dock.removeClass('expanded');
		}
		else if (state == 'show') {
			dockList.show();
			dock.addClass('expanded');
		}
		else {
			dockList.toggle();
			dock.toggleClass('expanded');
		}
	},

	_togglePlaces: function(event) {
		var myPlaces = event.data;

		var myPlacesList = myPlaces.find('> ul');

		myPlacesList.toggleClass('show-my-places');
	}
};
// file seperator

Liferay.DynamicSelect = new Class({

	/*
	array: an array of params
	params.select: a select box
	params.selectId: JSON object field name for an option value
	params.selectDesc: JSON object field name for an option description
	params.selectVal: selected value of the select box
	params.selectData: function that returns a JSON array to populate the next select box
	*/
	initialize: function(array) {
		var instance = this;

		instance.array = array;

		jQuery.each(
			array,
			function(i, params) {
				var select = jQuery('#' + params.select);
				var selectData = params.selectData;

				var prevSelectVal = null;

				if (i > 0) {
					prevSelectVal = array[i - 1].selectVal;
				}

				selectData(
					function(list) {
						instance._updateSelect(instance, i, list);
					},
					prevSelectVal
				);

				select.attr('name', select.attr('id'));

				select.bind(
					'change',
					function() {
						instance._callSelectData(instance, i);
					}
				);
			}
		);
	},

	_callSelectData: function(instance, i) {
		var array = instance.array;

		if ((i + 1) < array.length) {
			var curSelect = jQuery('#' + array[i].select);
			var nextSelectData = array[i + 1].selectData;

			nextSelectData(
				function(list) {
					instance._updateSelect(instance, i + 1, list);
				},
				curSelect.val()
			);
		}
	},

	_updateSelect: function(instance, i, list) {
		var params = instance.array[i];

		var select = jQuery('#' + params.select);
		var selectId = params.selectId;
		var selectDesc = params.selectDesc;
		var selectVal = params.selectVal;
		var selectNullable = params.selectNullable || true;

		var options = '';

		if (selectNullable) {
			options += '<option value="0"></option>';
		}

		jQuery.each(
			list,
			function(i, obj) {
				eval('var key = obj.' + selectId + ';');
				eval('var value = obj.' + selectDesc + ';');

				options += '<option value="' + key + '">' + value + '</option>';
			}
		);

		select.html(options);
		select.find('option[@value=' + selectVal + ']').attr('selected', 'selected');

		if (jQuery.browser.msie && jQuery.browser.version.number() <= 7) {
			select.css('width', 'auto');
		}
	}
});
// file seperator

(function(lib){

	lib.Freeform = function(portlet) {
		lib.Freeform.init(portlet);
	};

	lib.Freeform.extendNativeFunctionObject({
		_current: null,

		init: function(options) {
			var instance = this;

			// Set private variables
			instance._columns = options.columnSelector;
			instance._portlets = options.boxSelector;

			jQuery(instance._columns).find(instance._portlets).each(function() {
				instance.add(this);
			});
		},

		add: function(portlet) {
			var instance = this;
			portlet = _$J.getOne(portlet);

			var handle = _$J(".portlet-header-bar, .portlet-title-default, .portlet-topper", portlet).get(0);

			handle.style.cursor = "move";
			portlet.style.position = "absolute";

			_$J(portlet).lDrag({
				handle: handle,
				portlet: portlet,
				onStart: function(settings) {
					settings.wasClicked = true;
					settings.container.style.zIndex = 99;
				},
				onMove: function(settings) {
					settings.wasClicked = false;
				},
				onComplete: function(settings) {
					var portlet = settings.portlet;

					if (!settings.wasClicked) {
						var left = parseInt(portlet.style.left);
						var top = parseInt(portlet.style.top);

						left = Math.round(left/10) * 10;
						top = Math.round(top/10) * 10;

						portlet.style.left = left + "px";
						portlet.style.top = top + "px";

						instance.moveToTop(portlet);
						instance.savePosition(portlet);
					}
					portlet.style.zIndex = "";
				}
			});

			_$J(portlet).click(function() {
				if (instance._current != this) {
					instance.moveToTop(this);
					instance.savePosition(this, true);
					instance._current = this;
				}
			});

			var resizeBox = _$J(".portlet-content-container, .portlet-borderless-container", portlet);
			var resizeHandle = _$J(".portlet-resize-handle", portlet);

			if (!resizeHandle.length) {
				resizeBox.append("<div style='position:relative'><div class='portlet-resize-handle'></div></div>");
				resizeHandle = _$J(".portlet-resize-handle", portlet);
			}

			if (resizeBox.length && resizeHandle.length) {
				_$J(portlet).lResize({
					handle: resizeHandle[0],
					direction: "horizontal",
					mode: "add",
					portlet: portlet,
					onStart: function(settings) {
						instance.moveToTop(settings.container.resizeSettings.portlet);
					},
					onComplete: function(settings) {
						var portlet = settings.container.resizeSettings.portlet;
						var resizeBox = _$J(portlet).getOne(".portlet-content-container, .portlet-borderless-container");
						var height = parseInt(resizeBox.style.height);
						var width = parseInt(portlet.style.width);

						height = Math.round(height/10) * 10;
						width = Math.round(width/10) * 10;

						resizeBox.style.height = height + "px";
						portlet.style.width = width + "px";
						instance.savePosition(portlet);
					}
				});

				resizeBox.lResize({
					handle: resizeHandle[0],
					direction: "vertical",
					mode: "add"
				});
			}

			if ((parseInt(portlet.style.top) + parseInt(portlet.style.left)) == 0) {
				portlet.style.top = (20 * portlet.columnPos) + "px";
				portlet.style.left = (20 * portlet.columnPos) + "px";
			}
		},

		findPosition: function(portlet) {
			var position = -1;

			_$J(".portlet-boundary", portlet.parentNode).each(function(i) {
				if (this == portlet) {
					position = i;
				}
			});

			return position;
		},

		moveToTop: function(portlet) {
			var container = portlet.parentNode;
			portlet.oldPosition = this.findPosition(portlet);

			container.removeChild(portlet);
			container.appendChild(portlet);
		},

		savePosition : function(portlet, wasClicked) {
			var instance = this;
			var resizeBox = _$J(portlet).find(".portlet-content-container, .portlet-borderless-container")[0];
			var newPosition = Liferay.Portlet.findIndex(portlet);
			var cmd;

			if (newPosition != portlet.oldPosition) {
				Liferay.Portlet.savePosition(portlet);
			}

			if (resizeBox && !wasClicked) {
				AjaxUtil.request(themeDisplay.getPathMain() + "/portal/update_layout" +
					"?p_l_id=" + themeDisplay.getPlid() +
					"&height=" + resizeBox.style.height +
					"&width=" + portlet.style.width +
					"&top=" + portlet.style.top +
					"&left=" + portlet.style.left +
					"&p_p_id=" + portlet.portletId +
					"&doAsUserId=" + themeDisplay.getDoAsUserIdEncoded() +
					"&cmd=drag");
			}
		}
	});
})(Liferay);
// file seperator

var LayoutConfiguration = {
	categories : [],
	initialized : false,
	loadingImage : null,
	menu : null,
	menuDiv : null,
	menuIframe : null,
	portlets : [],
	showTimer : 0,

	init : function () {
		var arrow1 = new Image();
		var arrow2 = new Image();
		arrow1.src = themeDisplay.getPathThemeImages() + "/arrows/01_down.png";
		arrow2.src = themeDisplay.getPathThemeImages() + "/arrows/01_right.png";

		var menu = document.getElementById("portal_add_content");
		LayoutConfiguration.menu = menu;

		if (menu != null) {
			var list = menu.childNodes;

			for (var i = 0; i < list.length; i++) {
				if (list[i].className != null && list[i].className.match("portal-add-content")) {
					LayoutConfiguration.menuDiv = list[i];
				}
				if (list[i].nodeName != null && list[i].nodeName.toLowerCase().match("iframe")) {
					LayoutConfiguration.menuIframe = list[i];
				}
			}

			var elems = menu.getElementsByTagName("div");

			for (var i = 0; i < elems.length; i++) {
				if (elems[i].className == "layout_configuration_portlet") {
					LayoutConfiguration.portlets.push(elems[i]);
				}
				else if (elems[i].className == "layout_configuration_category") {
					LayoutConfiguration.categories.push(elems[i]);
				}
			}

			LayoutConfiguration.initialized = true;

			jQuery('#layout_configuration_content').trigger('focus').addClass('focus');
		}
	},

	toggle : function (plid, ppid, doAsUserId) {
		if (!LayoutConfiguration.menu) {
			var url = themeDisplay.getPathMain() + "/portal/render_portlet?p_l_id=" + plid + "&p_p_id=" + ppid + "&doAsUserId=" + doAsUserId + "&p_p_state=exclusive";
			var popup = Liferay.Popup({
					width: 250,
					noCenter: true,
					title: Liferay.Language.get("add-content"),
					onClose: function() {
						LayoutConfiguration.menu = null;
					}
				});
			AjaxUtil.update(url, popup, {
							onComplete: function() {
											LayoutConfiguration.init();
											Liferay.Util.addInputType();
											Liferay.Util.addInputFocus();
										}
									});
		}
	},

	startShowTimer : function (word) {
		if (this.showTimer) {
			clearTimeout(this.showTimer);
			this.showTimer = 0;
		}

		this.showTimer = setTimeout("LayoutConfiguration.showMatching(\"" + word + "\")", 250);
	},

	showMatching : function (word) {
		var portlets = this.portlets;
		var categories = this.categories;

		if (word == "*") {
			for (var i = 0; i < portlets.length; i++) {
				portlets[i].style.display = "block";
			}

			for (var i = 0; i < categories.length; i++) {
				categories[i].style.display = "block";
				this.toggleCategory(categories[i].getElementsByTagName("table")[0], "block");
			}
		}
		else if (word == "") {
			for (var i = 0; i < categories.length; i++) {
				categories[i].style.display = "block";
				this.toggleCategory(categories[i].getElementsByTagName("table")[0], "none");
			}
			for (var i = 0; i < portlets.length; i++) {
				portlets[i].style.display = "block";
			}
		}
		else {
			word = word.toLowerCase().match(/[a-z,A-Z,0-9]*/g).join("");

			for (var i = 0; i < categories.length; i++) {
				categories[i].style.display = "none";
			}

			for (var i = 0; i < portlets.length; i++) {
				if (portlets[i].id.toLowerCase().match(word)) {
					portlets[i].style.display = "block";

					this.showCategories(categories, portlets[i].id);
				}
				else {
					portlets[i].style.display = "none";
				}
			}
		}
	},

	showCategories : function (categories, name) {
		var colon = name.lastIndexOf(":");

		while (colon != -1) {
			name = name.substr(0, colon);

			for (var i = 0; i < categories.length; i++) {
				if (name.match(categories[i].id)) {
					categories[i].style.display = "block";
					this.toggleCategory(categories[i].getElementsByTagName("table")[0], "block");
				}
			}

			colon = name.lastIndexOf(":");
		}
	},

	toggleCategory : function (obj, display) {
		var parent = obj;

		while(parent.nodeName.toLowerCase() != "table") {
			parent = parent.parentNode;
		}

		var data = parent.rows[1].cells[0];
		var pane = _$J(".layout_configuration_category_pane:first", data).get(0);
		var image = obj.getElementsByTagName("img")[0];
		var imagePath = themeDisplay.getPathThemeImages();

		if (display) {
			pane.style.display = display;
			if (display.toLowerCase().match("block")) {
				image.src = imagePath + "/arrows/01_down.png";
			}
			else {
				image.src = imagePath + "/arrows/01_right.png";
			}
		}
		else {
			if (Liferay.Util.toggle(pane, true)) {
				image.src = imagePath + "/arrows/01_down.png";
			}
			else {
				image.src = imagePath + "/arrows/01_right.png";
			}
		}
	}

};
// file seperator

var Messaging = {
	checkRoster : false,
	currentChatBox : null,
	initialized : false,
	inputCount : 1,
	mainDiv : null,
	msgQueue : [],
	userId : null,
	windowCount : 0,
	zIndex : 1,

	chat : function(msgObj) {
		if (!msgObj && Messaging.msgQueue.length == 0) return;

		var msg = msgObj || Messaging.msgQueue.shift();
		var toDivId = msg.toId.replace(/\./g, "_");
		var chatBox = _$J("#msg-chat-box_" + toDivId)[0];

		if (!chatBox) {
			var contents =
				"<div class='msg-chat-box' id='msg-chat-box_" + toDivId + "'>" +
					"<input class='msg-to-input-id' type=hidden value='" + msg.toId + "' />" +
					"<div class='msg-chat-area textarea' style='overflow: auto; height: 100px'>" +
						(msg.messages || "") +
					"</div>" +
					"<input class='msg-type-area' style='width: 90%; margin-top: 5px' tabIndex=1 type='text' onKeyPress='Messaging.sendChat(this, event)' />" +
				"</div>";

			chatBox = Liferay.Popup({
				title: msg.toName,
				message: contents,
				noCenter: true,
				width: 300,
				onClose: function() { Messaging.saveCookie(); }
			});

			if (msg.status && msg.status == "unavailable") {
				_$J(chatBox).append(
					"<img src='" + themeDisplay.getPathThemeImages() + "/chat/add_user.png' " +
						"style='cursor: pointer; margin-top: 2px' " +
						"onclick=\"MessagingRoster.addEntry('" + msg.toId + "'); _$J(this).remove()\"" +
					"/>"
				);
			}

			Messaging.populateChatBox(chatBox, msg);

			if (msg.top != null && msg.left != null) {
				_$J(chatBox).parents(".popup:first").css({
					top: msg.top + "px",
					left: msg.left + "px"
				});
			}
			else {
				var count = Liferay.Popup.count();

				_$J(chatBox).parents(".popup:first").css({
					top: (count * 10) + "px",
					left: (count * 10) + "px"
				});
			}
		}
		else {
			this.populateChatBox(chatBox, msg);
		}
	},

	populateChatBox : function(chatBox, msg) {
		var typeArea = _$J.getOne(".msg-type-area", chatBox);
		var chatArea = _$J.getOne(".msg-chat-area", chatBox);

		if (msg.body != null) {
			var name = msg.toName.split(/[ ,.-]/);
			var initials = "";
			for (var i = 0; i < name.length; i++) {
				initials += name[i].charAt(0);
			}
			chatArea.innerHTML += "<span style='color: #FF0000'>" + initials + ": </span>" + msg.body + "<br/>";
			this.saveCookie();
		}

		chatArea.scrollTop = chatArea.scrollHeight;
		typeArea.focus();

		if (Liferay.Browser.is_ie) {
			// need double focus for IE
			typeArea.focus();
		}

		Messaging.chat();
	},

	getChats : function() {
		var url = themeDisplay.getPathMain() + "/messaging/action?cmd=getChats";
		AjaxUtil.request(url, {
			onComplete: function(xmlHttpReq) {
				var msg = eval("(" + xmlHttpReq.responseText + ")");
				Messaging.getChatsReturn(msg);
			}
		});
	},

	getChatsReturn : function(msg) {
		var status = msg.status;

		if (status == "success") {
			var chatMsg = msg.chat;
			if (chatMsg && chatMsg.length > 0) {
				for (var i = 0; i < chatMsg.length; i++) {
					// swap "from" and "to"
					var tmpName = chatMsg[i].fromName;
					var tmpId = chatMsg[i].fromId;
					chatMsg[i].fromName = chatMsg[i].toName;
					chatMsg[i].fromId = chatMsg[i].toId;
					chatMsg[i].toName = tmpName;
					chatMsg[i].toId = tmpId;
					Messaging.msgQueue.push(chatMsg[i]);
				}
				Messaging.chat();
				window.focus();
			}
		}
	},

	error : function() {
		alert("User does not exist");
	},

	init : function(userId) {
		var body = document.getElementsByTagName("body")[0];
		this.userId = userId;

		var msgJSON = _$J.cookie(this.userId + "_chats");

		if (msgJSON) {
			var chatArray = eval("(" + msgJSON + ")");

			for (var i = 0; i < chatArray.length; i++) {
				Messaging.msgQueue.push(chatArray[i]);
			}

			Messaging.chat();
		}

		this.initialized = true;
		Messaging.getChats();
	},

	maximizeChat : function(id) {
		var chatBox = _$J.getOne(id);
		var widthDiv = _$J.getOne(".msg-chat-box-width");
		var chatArea = _$J.getOne(".msg-chat-area");

		chatBox.style.left = Viewport.scroll().x + "px";
		chatBox.style.top = Viewport.scroll().y + "px";
		widthDiv.style.width = (Viewport.frame().x - 30) + "px";
		chatArea.style.height = (Viewport.frame().y - 100) + "px";
	},

	minimizeChat : function(id) {
		var chatBox = _$J.getOne(id);
		var widthDiv = _$J.getOne(".msg-chat-box-width");
		var chatArea = _$J.getOne(".msg-chat-area");

		widthDiv.style.width = 250 + "px";
		chatArea.style.height = 100 + "px";
	},

	removeChat : function(id) {
		var chatBox = _$J.getOne(id);

		Element.remove(chatBox);
		this.saveCookie();
	},

	saveCookie : function() {
		var chatList = _$J(".msg-chat-box");
		var jsonString = "[";

		chatList.each(function(i){
			var item = this;
			var popup = _$J(item).parents(".popup:first");

			jsonString += "{"
				+ "toName:\"" + popup.find(".popup-title")[0].innerHTML + "\","
				+ "toId:\"" +_$J(".msg-to-input-id", item)[0].value + "\","
				+ "top:" + parseInt(popup.css("top")) + ","
				+ "left:" + parseInt(popup.css("left")) + ","
				+ "messages:\"" + Liferay.Util.toJSONString(_$J(".msg-chat-area", item)[0].innerHTML) + "\"}";

			if (i < chatList.length - 1) {
				jsonString += ",";
			}
		});
		jsonString += "]";

		_$J.cookie(this.userId + "_chats", jsonString);
	},

	sendChat : function(obj, e) {
		var keycode;
		var chatBox = obj.parentNode;
		var toInput;
		var toAddr;
		var typeArea;
		var chatArea;
		var query = "cmd=sendChat";

		if (window.event) keycode = window.event.keyCode;
		else if (e) keycode = e.which;
		else return;

		if (keycode == 13) {
			var inputList = chatBox.getElementsByTagName("input");

			for (var i = 0; i < inputList.length ; i++) {
				if (inputList[i].className) {
					if (inputList[i].className.match("msg-to-input-id")) toInput = inputList[i];
					if (inputList[i].className.match("msg-to-input-addr")) toAddr = inputList[i];
					if (inputList[i].className.match("msg-type-area")) typeArea = inputList[i];
				}
			}

			if (typeArea.value == "") return;

			var divList = chatBox.getElementsByTagName("div");
			for (var i = 0; i < divList.length ; i++) {
				if (divList[i].className && divList[i].className.match("msg-chat-area")) chatArea = divList[i];
			}

			query += "&text=" + encodeURIComponent(typeArea.value);

			if (toAddr != null) {
				query += "&tempId=" + toInput.value + "&toAddr=" + toAddr.value;
			}
			else {
				query += "&toId=" + toInput.value;
			}

			loadPage(themeDisplay.getPathMain() + "/messaging/action", query, Messaging.sendChatReturn);

			chatArea.innerHTML += "<span style='color: #0000FF'>Me: </span>" + typeArea.value + "<br/>";
			chatArea.scrollTop = chatArea.scrollHeight;
			typeArea.value = "";

			Messaging.saveCookie();
		}
	},

	sendChatReturn : function(xmlHttpReq) {
		var msg = eval("(" + xmlHttpReq.responseText + ")");

		if (msg.status == "success") {
			Messaging.populateChatBox(msg);
		}
		else {
			Messaging.error();
		}
	}
};

var MessagingRoster = {
	highlightColor : "",
	lastSelected : null,

	addEntry : function(userId) {
		var url;

		if (userId) {
			url = themeDisplay.getPathMain() + "/chat/roster?cmd=addEntry&userId=" + userId;
		}
		else {
			var email = _$J.getOne("#portlet-chat-roster-email").value;
			url = themeDisplay.getPathMain() + "/chat/roster?cmd=addEntry&email=" + email
		}

		AjaxUtil.request(url, {onComplete: MessagingRoster.addEntryReturn});
	},

	addEntryReturn : function(xmlHttpReq) {
		try {
			var msg = eval("(" + xmlHttpReq.responseText + ")");

			if (msg.status == "failure") {
				alert("No such user exists");
			}
			else {
				var rosterDiv = _$J.getOne("#portlet-chat-roster-list");

				if (rosterDiv) {
					var entries = _$J(".portlet-chat-roster-entry", rosterDiv);
					var userId = msg.user;

					var userExists = entries.filter(function(i){
						return(this.userId == userId);
					});

					if (userExists.length != 0) {
						var entryRow = MessagingRoster.createEntryRow(msg.user, msg.name);

						rosterDiv.appendChild(entryRow);
					}

					MessagingRoster.toggleEmail();
				}
			}
		}
		catch (err) {
		}
	},

	createEntryRow : function (userId, userName, online) {
			var tempDiv = document.createElement("div");
			var tempImg = document.createElement("img");
			var tempLink = document.createElement("a");
			tempImg.align = "absmiddle";
			tempImg.style.marginRight = "5px";

			if (online) {
				tempImg.src = themeDisplay.getPathThemeImages() + "/chat/user_online.png";
			}
			else {
				tempImg.src = themeDisplay.getPathThemeImages() + "/chat/user_offline.png";
			}

			tempLink.innerHTML = userName;
			tempLink.href = "javascript: void(0)";
			tempLink.onclick = MessagingRoster.onEntryLinkClick;

			tempDiv.appendChild(tempImg);
			tempDiv.appendChild(tempLink);
			tempDiv.onclick = MessagingRoster.onEntryClick;
			tempDiv.userId = userId;
			tempDiv.userName = userName;
			tempDiv.style.cursor = "pointer";
			tempDiv.className = "portlet-chat-roster-entry";

			return tempDiv;
	},

	deleteEntries : function () {
		if (MessagingRoster.lastSelected) {
			var userId = MessagingRoster.lastSelected.userId;
			var lastSelected = MessagingRoster.lastSelected;

			lastSelected.parentNode.removeChild(lastSelected);
			MessagingRoster.lastSelected = null;

			loadPage(themeDisplay.getPathMain() + "/chat/roster", "cmd=deleteEntries&entries=" + userId, MessagingRoster.deleteEntriesReturn);
		}
	},

	deleteEntriesReturn : function (xmlHttpReq) {
		try {
			var msg = eval("(" + xmlHttpReq.responseText + ")");
		}
		catch (err) {
		}
	},

	getEntries : function() {
		var url = themeDisplay.getPathMain() + "/chat/roster?cmd=getEntries";
		AjaxUtil.request(url, {
			onComplete: function(xmlHttpReq) {
				var msg = eval("(" + xmlHttpReq.responseText + ")");
				MessagingRoster.getEntriesReturn(msg);
			}
		});
	},

	getEntriesReturn : function(msg) {
		MessagingRoster.updateEntries(msg.roster);
	},

	updateEntries : function(roster) {
		var rosterDiv = _$J.getOne("#portlet-chat-roster-list");

		if (rosterDiv != null) {
			rosterDiv.innerHTML = "";
		}
		else {
			Messaging.checkRoster = false;
			return;
		}

		for (var i = 0; i < roster.length; i++) {
			var entry = roster[i];
			var tempDiv =
				MessagingRoster.createEntryRow(
					entry.user,
					entry.name,
					entry.status == "available"
				);
			rosterDiv.appendChild(tempDiv);
		}
	},

	onEmailKeypress : function (obj, event) {
		var keyCode;

		if (window.event) keyCode = window.event.keyCode;
		else if (event) keyCode = event.which;
		else return;

		if (keyCode == 13) {
			MessagingRoster.addEntry();
		}
	},

	onEntryClick : function () {
		if (MessagingRoster.lastSelected != null) {
			MessagingRoster.lastSelected.style.backgroundColor = "transparent";
		}

		this.style.backgroundColor = MessagingRoster.highlightColor;

		MessagingRoster.lastSelected = this;
	},

	onEntryLinkClick : function () {
		var parent = this.parentNode;
		Messaging.chat({toId: parent.userId, toName: parent.userName});
	},

	toggleEmail : function() {
		var emailDiv = _$J.getOne("#portlet-chat-roster-email-div");

		if (emailDiv.style.display == "none") {
			emailDiv.style.display = "block";

			emailInput = _$J.getOne("#portlet-chat-roster-email");
			emailInput.value = "";
			emailInput.focus();
		}
		else {
			emailDiv.style.display = "none";
		}
	}
};

// file seperator

Liferay.Notice = new Class({
	/* Options:
		closeText: (String) the text to use for the "close" button. Set to false to not have a close button
		content: (String) the HTML or text to insert into.
		toggleText: (Object) the text to use for the "hide" and "show" button. Set to false to not have a hide button
		noticeClass: (String) class to add to the notice toolbar.
		onClose: (fn) a callback to execute when the toolbar is closed
		type: (String) either 'notice' or 'warning', depending on the type of the toolbar. Defaults to notice.
	*/
	initialize: function(params) {
		var instance = this;
		params = params || {};
		instance._noticeType = params.type || 'notice';
		instance._noticeClass = 'popup-alert-notice';
		instance._useCloseButton = true;
		instance._onClose = params.onClose;
		
		if (params.closeText !== false) {
			instance._closeText = params.closeText || Liferay.Language.get('close');
		} 
		else {
			instance._useCloseButton = false;
			instance._closeText = '';
		}
		
		instance._useToggleButton = false;
		instance._hideText = '';
		instance._showText = '';
		
		if (params.toggleText !== false) {
			params.toggleText = jQuery.extend(
				{
					hide: null, 
					show: null
				}, 
			params.toggleText);
			
			instance._hideText = params.toggleText.hide || Liferay.Language.get('hide');
			instance._showText = params.toggleText.show || Liferay.Language.get('show');
			instance._useToggleButton = true;
		} 
		
		if (instance._noticeType == 'warning') {
			instance._noticeClass = 'popup-alert-warning';
		}
		
		if (params.noticeClass) {
			instance._noticeClass += ' ' + params.noticeClass;
		}
		
		instance._content = params.content || '';
		
		instance._createHTML();
		
		return instance._notice;
	},

	_createHTML: function() {
		var instance = this;
		
		var notice = jQuery('<div class="' + instance._noticeClass + '"><div class="popup-alert-content"></div></div>');
		
		notice.html(instance._content);
		
		if (instance._useToggleButton) {
			var toggleButton = jQuery('<a class="toggle-button" href="javascript:;"><span>' + instance._hideText + '</span></a>');
			var toggleSpan = toggleButton.find('span');
			var height = 0;
			
			toggleButton.toggle(
				function() {
					notice.slideUp();
					toggleSpan.text(instance._showText);
				},
				function() {
					notice.slideDown();
					toggleSpan.text(instance._hideText);
				}
			);
			
			notice.append(toggleButton);
		}
		
		if (instance._useCloseButton) {
			var html = '<input class="submit popup-alert-close" type="submit" value="' + instance._closeText + '" />';
			
			notice.append(html);
			
			var closeButton = notice.find('.popup-alert-close');
			closeButton.click(
				function() {
					notice.slideUp('normal', 
						function() {
							notice.remove();
						}
					);
					
					if (instance._onClose) {
						instance._onClose();
					}
				}
			);
		}

		notice.appendTo('body');

		instance._notice = notice;
	}
});
// file seperator

Liferay.PortletCSS = {
	init: function(portletId) {
		var instance = this;

		var curPortletBoundaryId = 'p_p_id_' + portletId + '_';
		var obj = jQuery('#' + curPortletBoundaryId);
		var tabTrigger = 1;

		instance._portletId = portletId;
		instance._curPortlet = obj.find('.portlet');
		instance._curPortletWrapperId = instance._curPortlet.attr('id');
		instance._portletBoundaryId = curPortletBoundaryId;
		instance._newPanel = jQuery('#portlet-set-properties');

		if (!instance._curPortlet.length) {
			instance._curPortlet = obj;
			instance._curPortletWrapperId = curPortletBoundaryId;
		}

		var newPanel = instance._newPanel;

		if (instance._curPortlet.length) {
			if (!instance._newPanel.is('.instantiated')) {
				instance._newPanel.addClass('instantiated');

				instance._portletBoundaryIdVar = jQuery('#portlet-boundary-id');

				// Portlet config

				instance._customTitleInput = jQuery('#custom-title');
				instance._defaultPortletTitle = instance._curPortlet.find('.portlet-title').text();
				instance._customTitleCheckbox = jQuery('#use-custom-title-checkbox');
				instance._showBorders = jQuery('#show-borders');
				instance._borderNote = jQuery('#border-note');
				instance._portletLanguage = jQuery('#lfr-portlet-language');
				instance._portletLinksTarget = jQuery('#lfr-point-links');

				// Text

				instance._fontFamily = jQuery('#lfr-font-family');
				instance._fontWeight = jQuery('#lfr-font-bold');
				instance._fontStyle = jQuery('#lfr-font-italic');
				instance._fontSize = jQuery('#lfr-font-size');
				instance._fontColor = jQuery('#lfr-font-color');
				instance._textAlign = jQuery('#lfr-font-align');
				instance._textDecoration = jQuery('#lfr-font-decoration');
				instance._wordSpacing = jQuery('#lfr-font-space');
				instance._leading = jQuery('#lfr-font-leading');
				instance._tracking = jQuery('#lfr-font-tracking');

				// Background

				instance._backgroundColor = jQuery('#lfr-bg-color');

				instance._useBgImage = jQuery('#lfr-use-bg-image');
				instance._bgImageProperties = jQuery('.lfr-bg-image-properties');

				instance._bgRepeating = jQuery('#lfr-bg-repeat');

				instance._bgPosTop = jQuery('#lfr-bg-top-int');
				instance._bgPosTopUnit = jQuery('#lfr-bg-top-unit');
				instance._bgPosLeft = jQuery('#lfr-bg-left-int');
				instance._bgPosLeftUnit = jQuery('#lfr-bg-left-unit');

				// Border

				instance._ufaBorderWidth = jQuery('#lfr-use-for-all-width');
				instance._ufaBorderStyle = jQuery('#lfr-use-for-all-style');
				instance._ufaBorderColor = jQuery('#lfr-use-for-all-color');

				instance._borderTopInt = jQuery('#lfr-border-width-top');
				instance._borderTopUnit = jQuery('#lfr-border-width-top-unit');
				instance._borderRightInt = jQuery('#lfr-border-width-right');
				instance._borderRightUnit = jQuery('#lfr-border-width-right-unit');
				instance._borderBottomInt = jQuery('#lfr-border-width-bottom');
				instance._borderBottomUnit = jQuery('#lfr-border-width-bottom-unit');
				instance._borderLeftInt = jQuery('#lfr-border-width-left');
				instance._borderLeftUnit = jQuery('#lfr-border-width-left-unit');

				instance._borderTopStyle = jQuery('#lfr-border-style-top');
				instance._borderRightStyle = jQuery('#lfr-border-style-right');
				instance._borderBottomStyle = jQuery('#lfr-border-style-bottom');
				instance._borderLeftStyle = jQuery('#lfr-border-style-left');

				instance._borderTopColor = jQuery('#lfr-border-color-top');
				instance._borderRightColor = jQuery('#lfr-border-color-right');
				instance._borderBottomColor = jQuery('#lfr-border-color-bottom');
				instance._borderLeftColor = jQuery('#lfr-border-color-left');

				// Spacing

				instance._ufaPadding = jQuery('#lfr-use-for-all-padding');
				instance._ufaMargin = jQuery('#lfr-use-for-all-margin');

				instance._paddingTopInt = jQuery('#lfr-padding-top');
				instance._paddingTopUnit = jQuery('#lfr-padding-top-unit');
				instance._paddingRightInt = jQuery('#lfr-padding-right');
				instance._paddingRightUnit = jQuery('#lfr-padding-right-unit');
				instance._paddingBottomInt = jQuery('#lfr-padding-bottom');
				instance._paddingBottomUnit = jQuery('#lfr-padding-bottom-unit');
				instance._paddingLeftInt = jQuery('#lfr-padding-left');
				instance._paddingLeftUnit = jQuery('#lfr-padding-left-unit');

				instance._marginTopInt = jQuery('#lfr-margin-top');
				instance._marginTopUnit = jQuery('#lfr-margin-top-unit');
				instance._marginRightInt = jQuery('#lfr-margin-right');
				instance._marginRightUnit = jQuery('#lfr-margin-right-unit');
				instance._marginBottomInt = jQuery('#lfr-margin-bottom');
				instance._marginBottomUnit = jQuery('#lfr-margin-bottom-unit');
				instance._marginLeftInt = jQuery('#lfr-margin-left');
				instance._marginLeftUnit = jQuery('#lfr-margin-left-unit');

				// Advanced CSS

				instance._customCSS = jQuery('#lfr-custom-css');

				instance._saveButton = jQuery('#lfr-lookfeel-save');
				instance._resetButton = jQuery('#lfr-lookfeel-reset');

				newPanel.show();

				newPanel.tabs({
					tabStruct: 'form>fieldset',
					selectedClass: 'current'
				});

				instance._currentPopup = Liferay.Popup({
					width: 800,
					message: newPanel[0],
					modal: false,
					noCenter: true,
					onClose: function() {
						instance._newPanel.removeClass('instantiated');
						jQuery(newPanel[0]).hide().appendTo('body');

						if (Liferay.Browser.is_ie_6) {
							window.location.reload(true);
						}
					}
				});

			}

			newPanel.find('.lfr-color-picker-img').remove();

			instance._portletMsgResponse = jQuery('#lfr-portlet-css-response');
			instance._portletMsgResponse.hide();

			var defaultData = {
				advancedData: {
					customCSS: ''
				},

				bgData: {
					backgroundColor: '',
					backgroundImage: '',
					useBgImage: false,
					backgroundRepeat: '',
					backgroundPosition: {
						left: {
							value: '',
							unit: 'px'
						},
						top: {
							value: '',
							unit: 'px'
						}
					}
				},

				borderData: {
					borderWidth: {
						bottom: {
							value: '',
							unit: 'px'
						},
						left: {
							value: '',
							unit: 'px'
						},
						right: {
							value: '',
							unit: 'px'
						},
						top: {
							value: '',
							unit: 'px'
						},
						sameForAll: true
					},

					borderStyle: {
						bottom: '',
						left: '',
						right: '',
						top: '',
						sameForAll: true
					},

					borderColor: {
						bottom: '',
						left: '',
						right: '',
						top: '',
						sameForAll: true
					}
				},

				portletData: {
					language: 'en_US',
					portletLinksTarget: '',
					showBorders: true,
					title: '',
					titles: {},
					useCustomTitle: false
				},

				spacingData: {
					margin: {
						bottom: {
							value: '',
							unit: 'px'
						},
						left: {
							value: '',
							unit: 'px'
						},
						right: {
							value: '',
							unit: 'px'
						},
						top: {
							value: '',
							unit: 'px'
						},
						sameForAll: true
					},
					padding: {
						bottom: {
							value: '',
							unit: 'px'
						},
						left: {
							value: '',
							unit: 'px'
						},
						right: {
							value: '',
							unit: 'px'
						},
						top: {
							value: '',
							unit: 'px'
						},
						sameForAll: true
					}

				},

				textData: {
					textAlign: '',
					color: '',
					fontFamily: '',
					fontSize: '',
					fontStyle: '',
					fontWeight: '',
					letterSpacing: '',
					lineHeight: '',
					textDecoration: '',
					wordSpacing: ''
				}
			};

			var objectData = jQuery.ajax(
				{
					url: themeDisplay.getPathMain() + '/portlet_configuration/get_look_and_feel',
					data: {
						p_l_id: themeDisplay.getPlid(),
						doAsUserId: themeDisplay.getDoAsUserIdEncoded(),
						portletId: instance._portletId
					},
					async: false,
					dataType: 'json',
					type: "POST"
				}
			);

			if (objectData.responseText.length) {
				objectData = jQuery.parseJSON(objectData.responseText);

				instance._objData = objectData;
			}
			else {
				instance._objData = defaultData;
			}

			instance._assignColorPickers();

			instance._portletBoundaryIdVar.val(curPortletBoundaryId);

			instance._setDefaults();

			instance._portletConfig();
			instance._textStyles();
			instance._backgroundStyles();
			instance._borderStyles();
			instance._spacingStyles();
			instance._cssStyles();

			var currentTab = newPanel.find('li.current');

			newPanel.triggerTab(tabTrigger);

			if (currentTab.length > 1) {
				currentTab.not(':first').removeClass('current');
			}

			var useForAll = newPanel.find('.lfr-use-for-all');

			var handleForms = function() {
				var checkBox = jQuery(this);
				var otherHolders = checkBox.parents('fieldset:first').find('.ctrl-holder:gt(1)');
				var otherForms = otherHolders.find('input, select');
				var colorPickerImages = otherHolders.find('.lfr-color-picker-img');

				if (this.checked) {
					otherHolders.fadeTo('fast', 0.3);
					otherForms.attr('disabled', true);
					colorPickerImages.hide();
				}
				else {
					otherHolders.fadeTo('fast', 1);
					otherForms.attr('disabled', false);
					colorPickerImages.show();
				}
			};

			useForAll.unbind('click', handleForms).click(handleForms);
			useForAll.each(handleForms);

			var saveHandler = function(xHR, type) {
				var ajaxResponseMsg = instance._portletMsgResponse;
				var ajaxResponseHTML = '<div id="lfr-portlet-css-response"></div>';
				var message = '';
				var messageClass = '';

				if (type == 'success') {
					message = Liferay.Language.get('your-request-processed-successfully');
					messageClass = 'portlet-msg-success';
				}
				else {
					message = Liferay.Language.get('your-settings-could-not-be-saved');
					messageClass = 'portlet-msg-error';
				}

				if (!ajaxResponseMsg.length) {
					ajaxResponse = jQuery(ajaxResponseHTML);
					instance._newPanel.find('form').prepend(ajaxResponse);
					instance._portletMsgResponse = ajaxResponse;
				}

				ajaxResponse.hide();
				ajaxResponse.attr('class', messageClass);
				ajaxResponse.empty();
				ajaxResponse.html(message);
				ajaxResponse.fadeIn('normal');
			};

			instance._saveButton.unbind().click(
				function() {
					instance._objData.advancedData.customCSS = instance._customCSS.val();

					jQuery.ajax(
						{
							url: themeDisplay.getPathMain() + '/portlet_configuration/update_look_and_feel',
							data: {
								p_l_id: themeDisplay.getPlid(),
								doAsUserId: themeDisplay.getDoAsUserIdEncoded(),
								portletId: instance._portletId,
								css: jQuery.toJSON(instance._objData)
							},
							complete: saveHandler,
							type: "POST"
						}
					);
				}
			);

			instance._resetButton.unbind().click(
				function() {
					instance._curPortlet.attr('style', '');
					jQuery('#lfr-custom-css-block-' + instance._curPortletWrapperId).remove();
					instance._objData = defaultData;
					instance._setDefaults();
				}
			);

			Liferay.Util.addInputFocus(instance._newPanel[0]);

			jQuery(instance._currentPopup).parents('.popup').ScrollTo(800);
		}
	},

	_assignColorPickers: function() {
		var instance = this;
		instance._newPanel.find('.use-color-picker').each(
			function() {
				new Liferay.ColorPicker(
					{
						context: jQuery('#portlet-set-properties')[0],
						item: this
					}
				);
			}
		);

	},

	_backgroundStyles: function() {
		var instance = this;

		var bgData = instance._objData.bgData;

		var portlet = instance._curPortlet;

		// Background color

		var backgroundColor = instance._backgroundColor;

		var setColor = function(obj){
			var color = obj.value;

			var cssColor = color;

			if ((color == '') || (color == '#')) {
				cssColor = 'transparent';
				color = '';
			}

			portlet.css('background-color', cssColor);
			bgData.backgroundColor = color;
		};

		var colorPicker = new Liferay.ColorPicker(
			{
				context: instance._newPanel[0],
				item: backgroundColor[0],
				onChange: function() {
					setColor(backgroundColor[0]);
				}
			}
		);

		backgroundColor.unbind().blur(
			function() {
				setColor(this);
			}
		);

		// Background image

		var useBgImage = instance._useBgImage;
		var useBg = useBgImage.is(':checked');
		var bgImageProperties = instance._bgImageProperties;

		bgData.useBgImage = useBg;

		if (useBg) {
			bgImageProperties.show();
		}

		useBgImage.unbind().click(
			function() {
				bgImageProperties.toggle();
				bgData.useBgImage = this.checked;
			}
		);

		// Background repeating

		var bgRepeating = instance._bgRepeating;

		bgRepeating.unbind().change(
			function() {
				var backgroundRepeat = this.options[this.selectedIndex].value;
				portlet.css('background-repeat', backgroundRepeat);

				bgData.backgroundRepeat = backgroundRepeat;
			}
		);

		// Background position

		var bgPosTop = instance._bgPosTop;
		var bgPosTopUnit = instance._bgPosTopUnit;

		var bgPosLeft = instance._bgPosLeft;
		var bgPosLeftUnit = instance._bgPosLeftUnit;

		var updatePos = function() {
			var topPos = instance._getCombo(bgPosTop, bgPosTopUnit);
			var leftPos = instance._getCombo(bgPosLeft, bgPosLeftUnit);

			portlet.css('background-position', leftPos.both + ' ' + topPos.both);

			bgData.backgroundPosition.top.value = topPos.input;
			bgData.backgroundPosition.top.unit = topPos.selectBox;

			bgData.backgroundPosition.left.value = leftPos.input;
			bgData.backgroundPosition.left.unit = leftPos.selectBox;
		};

		bgPosTop.unbind().blur(updatePos);
		bgPosLeft.unbind().blur(updatePos);
		bgPosTop.unbind().keyup(updatePos);
		bgPosLeft.unbind().keyup(updatePos);

		bgPosTopUnit.unbind().change(updatePos);
		bgPosLeftUnit.unbind().change(updatePos);
	},

	_borderStyles: function() {
		var instance = this;

		var portlet = instance._curPortlet;

		var ufaWidth = instance._ufaBorderWidth;
		var ufaStyle = instance._ufaBorderStyle;
		var ufaColor = instance._ufaBorderColor;

		var borderData = instance._objData.borderData;

		// Border width

		var wTopInt = instance._borderTopInt;
		var wTopUnit = instance._borderTopUnit;
		var wRightInt = instance._borderRightInt;
		var wRightUnit = instance._borderRightUnit;
		var wBottomInt = instance._borderBottomInt;
		var wBottomUnit = instance._borderBottomUnit;
		var wLeftInt = instance._borderLeftInt;
		var wLeftUnit = instance._borderLeftUnit;

		var changeWidth = function() {
			var styling = {};
			var borderWidth = {};

			borderWidth = instance._getCombo(wTopInt, wTopUnit);
			styling = {borderWidth: borderWidth.both};

			var ufa = ufaWidth.is(':checked');

			borderData.borderWidth.top.value = borderWidth.input;
			borderData.borderWidth.top.unit = borderWidth.selectBox;
			borderData.borderWidth.sameForAll = ufa;

			if (!ufa) {
				var extStyling = {};

				extStyling.borderTopWidth = styling.borderWidth;

				var right = instance._getCombo(wRightInt, wRightUnit);
				var bottom = instance._getCombo(wBottomInt, wBottomUnit);
				var left = instance._getCombo(wLeftInt, wLeftUnit);

				extStyling.borderRightWidth = right.both;
				extStyling.borderBottomWidth = bottom.both;
				extStyling.borderLeftWidth = left.both;

				styling = extStyling;

				borderData.borderWidth.right.value = right.input;
				borderData.borderWidth.right.unit = right.selectBox;

				borderData.borderWidth.bottom.value = bottom.input;
				borderData.borderWidth.bottom.unit = bottom.selectBox;

				borderData.borderWidth.left.value = left.input;
				borderData.borderWidth.left.unit = left.selectBox;
			}

			portlet.css(styling);

			changeStyle();
			changeColor();
		};

		wTopInt.unbind().blur(changeWidth);
		wTopInt.unbind().keyup(changeWidth);

		wRightInt.unbind().blur(changeWidth);
		wRightInt.unbind().keyup(changeWidth);

		wBottomInt.unbind().blur(changeWidth);
		wBottomInt.unbind().keyup(changeWidth);

		wLeftInt.unbind().blur(changeWidth);
		wLeftInt.unbind().keyup(changeWidth);

		wTopUnit.unbind().change(changeWidth);
		wRightUnit.unbind().change(changeWidth);
		wBottomUnit.unbind().change(changeWidth);
		wLeftUnit.unbind().change(changeWidth);

		ufaWidth.unbind().click(changeWidth);

		// Border style

		var sTopStyle = instance._borderTopStyle;
		var sRightStyle = instance._borderRightStyle;
		var sBottomStyle = instance._borderBottomStyle;
		var sLeftStyle = instance._borderLeftStyle;

		var changeStyle = function() {
			var styling = {};
			var borderStyle = {};

			borderStyle = sTopStyle.find('option:selected').val();
			styling = {borderStyle: borderStyle};
			var ufa = ufaStyle.is(':checked');

			borderData.borderStyle.top = borderStyle;
			borderData.borderStyle.sameForAll = ufa;

			if (!ufa) {
				var extStyling = {};

				extStyling.borderTopStyle = styling.borderStyle;

				var right = sRightStyle.find('option:selected').val();
				var bottom = sBottomStyle.find('option:selected').val();
				var left = sLeftStyle.find('option:selected').val();

				extStyling.borderRightStyle = right;
				extStyling.borderBottomStyle = bottom;
				extStyling.borderLeftStyle = left;

				styling = extStyling;

				borderData.borderStyle.right = right;

				borderData.borderStyle.bottom = bottom;

				borderData.borderStyle.left = left;
			}

			portlet.css(styling);
		};

		sTopStyle.unbind().change(changeStyle);
		sRightStyle.unbind().change(changeStyle);
		sBottomStyle.unbind().change(changeStyle);
		sLeftStyle.unbind().change(changeStyle);

		ufaStyle.unbind().click(changeStyle);

		// Border color

		var cTopColor = instance._borderTopColor;
		var cRightColor = instance._borderRightColor;
		var cBottomColor = instance._borderBottomColor;
		var cLeftColor = instance._borderLeftColor;

		var changeColor = function() {
			var styling = {};
			var borderColor = {};

			borderColor = cTopColor.val();
			styling = {borderColor: borderColor};

			var ufa = ufaColor.is(':checked');

			borderData.borderColor.top = borderColor;
			borderData.borderColor.sameForAll = ufa;

			if (!ufa) {
				var extStyling = {};

				extStyling.borderTopColor = styling.borderColor;

				var right = cRightColor.val();
				var bottom = cBottomColor.val();
				var left = cLeftColor.val();

				extStyling.borderRightColor = right;
				extStyling.borderBottomColor = bottom;
				extStyling.borderLeftColor = left;

				styling = extStyling;

				borderData.borderColor.right = right;

				borderData.borderColor.bottom = bottom;

				borderData.borderColor.left = left;
			}

			portlet.css(styling);
		};

		var colorPickerTop = new Liferay.ColorPicker(
			{
				context: jQuery('#portlet-set-properties')[0],
				item: cTopColor[0],
				onChange: changeColor
			}
		);

		var colorPickerRight = new Liferay.ColorPicker(
			{
				context: jQuery('#portlet-set-properties')[0],
				item: cRightColor[0],
				onChange: changeColor
			}
		);

		var colorPickerBottom = new Liferay.ColorPicker(
			{
				context: jQuery('#portlet-set-properties')[0],
				item: cBottomColor[0],
				onChange: changeColor
			}
		);

		var colorPickerLeft = new Liferay.ColorPicker(
			{
				context: jQuery('#portlet-set-properties')[0],
				item: cLeftColor[0],
				onChange: changeColor
			}
		);

		cTopColor.unbind().blur(changeColor);
		cRightColor.unbind().blur(changeColor);
		cBottomColor.unbind().blur(changeColor);
		cLeftColor.unbind().blur(changeColor);

		cTopColor.unbind().keyup(changeColor);
		cRightColor.unbind().keyup(changeColor);
		cBottomColor.unbind().keyup(changeColor);
		cLeftColor.unbind().keyup(changeColor);

		ufaColor.unbind().click(changeColor);

	},

	_cssStyles: function() {
		var instance = this;

		var portlet = instance._curPortlet;

		var customCSS = jQuery('#lfr-custom-css');
		var customCSSContainer = customCSS.parents('.ctrl-holder');
		var customPortletNoteHTML = '<p class="portlet-msg-info form-hint"></p>';
		var customPortletNote = jQuery('#lfr-portlet-info');
		var refreshText = '';

		var portletId = instance._curPortletWrapperId;
		var portletClasses = portlet.attr('class');

		portletClasses = jQuery.trim(portletClasses).replace(/(\s)/g, '$1.');

		var portletInfoText =
			Liferay.Language.get('your-current-portlet-information-is-as-follows') + ':<br />' +
				Liferay.Language.get('portlet-id') + ': <strong>#' + portletId + '</strong><br />' +
					Liferay.Language.get('portlet-classes') + ': <strong>.' + portletClasses + '</strong>';

		var customNote = jQuery('#lfr-refresh-styles');

		if (!customNote.length) {
			customNote = jQuery(customPortletNoteHTML);
			customNote.attr(
				{
					'class': '',
					id: 'lfr-refresh-styles'
				}
			);
		}

		if (!customPortletNote.length) {
			customPortletNote = jQuery(customPortletNoteHTML);
			customCSSContainer.before(customPortletNote);

			customPortletNote.attr(
				{
					id: 'lfr-portlet-info'
				}
			);
		}

		customPortletNote.html(portletInfoText);

		customCSS.EnableTabs();

		if (!jQuery.browser.safari) {
			refreshText = Liferay.Language.get('update-the-styles-on-this-page');

			var refreshLink = jQuery('<a href="javascript:;">' + refreshText + '</a>');

			var customStyleBlock = jQuery('#lfr-custom-css-block-' + portletId);

			if (!customStyleBlock.length) {

				// Do not modify. This is a workaround for an IE bug.

				var styleEl = document.createElement('style');

				styleEl.id = 'lfr-custom-css-block-' + portletId;
				styleEl.className = 'lfr-custom-css-block';
				styleEl.setAttribute('type', 'text/css');

				document.getElementsByTagName('head')[0].appendChild(styleEl);
			}
			else {
				styleEl = customStyleBlock[0];
			}

			var refreshStyles = function() {
				var customStyles = customCSS.val();

				customStyles = customStyles.replace(/<script[^>]*>([\u0001-\uFFFF]*?)<\/script>/gim, '');
				customStyles = customStyles.replace(/<\/?[^>]+>/gi, '');

				if (styleEl.styleSheet) { // for IE only
					if (customStyles == '') {

						// Do not modify. This is a workaround for an IE bug.

						customStyles = '<!---->';
					}
					styleEl.styleSheet.cssText = customStyles;
				}
				else {
					jQuery(styleEl).html(customStyles);
				}
			};

			refreshLink.unbind().click(refreshStyles);

			customNote.empty().append(refreshLink);
		}
		else {
			refreshText = Liferay.Language.get('please-press-the-save-button-to-view-your-changes');

			customNote.empty().text(refreshText);
		}

		var insertContainer = jQuery('#lfr-add-rule-container');
		var addIdLink = jQuery('#lfr-add-id');
		var addClassLink = jQuery('#lfr-add-class');
		var updateOnType = jQuery('#lfr-update-on-type');

		if (!insertContainer.length) {
			insertContainer = jQuery('<div id="lfr-add-rule-container"></div>');
			addIdLink = jQuery('<a href="javascript:;" id="lfr-add-id">' + Liferay.Language.get('add-a-css-rule-for-just-this-portlet') + '</a>');
			addClassLink = jQuery('<a href="javascript:;" id="lfr-add-class">' + Liferay.Language.get('add-a-css-rule-for-all-portlets-like-this-one') + '</a>');

			var updateOnTypeHolder = jQuery('<div class="ctrl-holder"></div>');
			var updateOnTypeLabel = jQuery('<label>' + Liferay.Language.get('update-my-styles-as-i-type') + ' </label>');

			updateOnType = jQuery('<input id="lfr-update-on-type" type="checkbox" />');

			updateOnTypeLabel.append(updateOnType);
			updateOnTypeHolder.append(updateOnTypeLabel);

			customCSSContainer.after(insertContainer);

			insertContainer.append(addIdLink);
			insertContainer.append('<br />');
			insertContainer.append(addClassLink);
			insertContainer.append(updateOnTypeHolder);

			insertContainer.after(customNote);
		}

		updateOnType.click(
			function() {
				if (this.checked) {
					customNote.hide();
					customCSS.keyup(refreshStyles);
				}
				else {
					customNote.show();
					customCSS.unbind('keyup', refreshStyles);
				}
			}
		);

		addIdLink.unbind().click(
			function() {
				customCSS[0].value += '\n#' + portletId + '{\n\t\n}\n';
			}
		);

		addClassLink.unbind().click(
			function() {
				customCSS[0].value += '\n.' + portletClasses.replace(/\s/g, '') + '{\n\t\n}\n';
			}
		);
	},

	_getCombo: function(input, selectBox) {
		var instance = this;

		var inputVal = input.val();
		var selectVal = selectBox.find('option:selected').val();

		inputVal = instance._getSafeInteger(inputVal);

		return {input: inputVal, selectBox: selectVal, both: inputVal + selectVal};
	},

	_getSafeInteger: function(input) {
		var instance = this;

		var output = parseInt(input);

		if (output == '' || isNaN(output)) {
			output = 0;
		}

		return output;
	},

	_languageClasses: function(key, value, removeClass) {
		var instance = this;

		var option = instance._portletLanguage.find('option[@value=' + key + ']');

		if (removeClass) {
			option.removeClass('focused');
		}
		else {
			option.addClass('focused');
		}
	},

	_portletConfig: function() {
		var instance = this;

		var portletData = instance._objData.portletData;
		var customTitleInput = instance._customTitleInput;
		var customTitleCheckbox = instance._customTitleCheckbox;
		var showBorders = instance._showBorders;
		var language = instance._portletLanguage;
		var borderNote = instance._borderNote;
		var portletLinksTarget = instance._portletLinksTarget;

		// Use custom title

		customTitleCheckbox.unbind().click(
			function() {
				var title;

				portletData.useCustomTitle = this.checked;

				if (this.checked) {
					customTitleInput.attr('disabled', false);
					language.attr('disabled', false);
					title = jQuery.trim(customTitleInput.val());

					if (title == '') {
						title = instance._curPortlet.find('.portlet-title').text();
						title = jQuery.trim(title);
						customTitleInput.val(title);
					}

					portletData.title = title;
					instance._portletTitles(false, title);
				}
				else {
					customTitleInput.attr('disabled', true);
					language.attr('disabled', true);
					title = instance._defaultPortletTitle;
				}

				instance._curPortlet.find('.portlet-title').text(title);
			}
		);

		customTitleInput.unbind().keyup(
			function() {
				if (!portletData.useCustomTitle) {
					return;
				}

				instance._curPortlet.find('.portlet-title').text(this.value);
				portletData.title = this.value;
				instance._portletTitles(false, this.value);
			}
		);

		// Show borders

		showBorders.unbind().click(
			function() {
				borderNote.toggle();
				portletData.showBorders = this.checked;
			}
		);

		language.change(
			function() {
				portletData.language = this.options[this.selectedIndex].value;

				var title = instance._portletTitles(portletData.language);

				if (portletData.useCustomTitle) {
					customTitleInput.val(title);
				}
			}
		);

		// Point target links to

		portletLinksTarget.change(
			function() {
				portletData.portletLinksTarget = instance._getSafeInteger(this.options[this.selectedIndex].value);
			}
		);
	},

	_portletTitles: function(key, value) {
		var instance = this;

		var portletLanguage = instance._portletLanguage;

		if (!instance._objData.portletData.titles) {
			instance._objData.portletData.titles = {};
		}

		var portletTitles = instance._objData.portletData.titles;

		if (!key) {
			key = instance._portletLanguage.find('option:selected').val();
		}

		if (value == null) {
			var portletTitle = portletTitles[key];

			if (portletTitle) {
				return portletTitle;
			}

			return '';
		}
		else {
			portletTitles[key] = value;

			if (value == '') {
				instance._languageClasses(key, null, true);
			}
			else {
				instance._languageClasses(key);
			}
		}
	},

	_setCheckbox: function(obj, value) {
		var instance = this;

		obj.attr('checked', value);
	},

	_setDefaults: function() {
		var instance = this;

		var objData = instance._objData;

		var portletData = objData.portletData;
		var textData = objData.textData;
		var bgData = objData.bgData;
		var borderData = objData.borderData;
		var spacingData = objData.spacingData;

		var portletTitles = portletData.titles;
		var portletTitle = instance._portletTitles(portletData.language);

		var fontStyle = false;
		var fontWeight = false;

		if (textData.fontStyle != 'normal') {
			fontStyle = true;
		}

		if (textData.fontWeight != 'normal') {
			fontWeight = true;
		}

		// Portlet config

		instance._setInput(instance._customTitleInput, portletTitle);
		instance._setCheckbox(instance._customTitleCheckbox, portletData.useCustomTitle);
		instance._setCheckbox(instance._showBorders, portletData.showBorders);
		instance._setSelect(instance._portletLanguage, portletData.language);
		instance._setSelect(instance._portletLinksTarget, portletData.portletLinksTarget);

		if (!portletData.useCustomTitle) {
			instance._customTitleInput.attr('disabled', true);
			instance._portletLanguage.attr('disabled', true);
		}

		if (portletData.titles) {
			jQuery.each(portletData.titles,
				function(key, value) {
					instance._languageClasses(key);
				}
			);
		}

		// Text

		instance._setSelect(instance._fontFamily, textData.fontFamily);
		instance._setCheckbox(instance._fontWeight, fontWeight);
		instance._setCheckbox(instance._fontStyle, fontStyle);
		instance._setSelect(instance._fontSize, textData.fontSize);
		instance._setInput(instance._fontColor, textData.color);
		instance._setSelect(instance._textAlign, textData.textAlign);
		instance._setSelect(instance._textDecoration, textData.textDecoration);
		instance._setSelect(instance._wordSpacing, textData.wordSpacing);
		instance._setSelect(instance._leading, textData.lineHeight);
		instance._setSelect(instance._tracking, textData.letterSpacing);

		// Background

		instance._setInput(instance._backgroundColor, bgData.backgroundColor);
		instance._setCheckbox(instance._useBgImage, bgData.useBgImage);
		instance._setSelect(instance._bgRepeating, bgData.backgroundRepeat);
		instance._setInput(instance._bgPosTop, bgData.backgroundPosition.top.value);
		instance._setSelect(instance._bgPosTopUnit, bgData.backgroundPosition.top.unit);
		instance._setInput(instance._bgPosLeft, bgData.backgroundPosition.left.value);
		instance._setSelect(instance._bgPosLeftUnit, bgData.backgroundPosition.left.unit);

		// Border

		instance._setCheckbox(instance._ufaBorderWidth, borderData.borderWidth.sameForAll);
		instance._setCheckbox(instance._ufaBorderStyle, borderData.borderStyle.sameForAll);
		instance._setCheckbox(instance._ufaBorderColor, borderData.borderColor.sameForAll);

		instance._setInput(instance._borderTopInt, borderData.borderWidth.top.value);
		instance._setSelect(instance._borderTopUnit, borderData.borderWidth.top.unit);
		instance._setInput(instance._borderRightInt, borderData.borderWidth.right.value);
		instance._setSelect(instance._borderRightUnit, borderData.borderWidth.right.unit);
		instance._setInput(instance._borderBottomInt, borderData.borderWidth.bottom.value);
		instance._setSelect(instance._borderBottomUnit, borderData.borderWidth.bottom.unit);
		instance._setInput(instance._borderLeftInt, borderData.borderWidth.left.value);
		instance._setSelect(instance._borderLeftUnit, borderData.borderWidth.left.unit);

		instance._setSelect(instance._borderTopStyle, borderData.borderStyle.top);
		instance._setSelect(instance._borderRightStyle, borderData.borderStyle.right);
		instance._setSelect(instance._borderBottomStyle, borderData.borderStyle.bottom);
		instance._setSelect(instance._borderLeftStyle, borderData.borderStyle.left);

		instance._setInput(instance._borderTopColor, borderData.borderColor.top);
		instance._setInput(instance._borderRightColor, borderData.borderColor.right);
		instance._setInput(instance._borderBottomColor, borderData.borderColor.bottom);
		instance._setInput(instance._borderLeftColor, borderData.borderColor.left);

		// Spacing

		instance._setCheckbox(instance._ufaPadding, spacingData.padding.sameForAll);
		instance._setCheckbox(instance._ufaMargin, spacingData.margin.sameForAll);

		instance._setInput(instance._paddingTopInt, spacingData.padding.top.value);
		instance._setSelect(instance._paddingTopUnit, spacingData.padding.top.unit);
		instance._setInput(instance._paddingRightInt, spacingData.padding.right.value);
		instance._setSelect(instance._paddingRightUnit, spacingData.padding.right.unit);
		instance._setInput(instance._paddingBottomInt, spacingData.padding.bottom.value);
		instance._setSelect(instance._paddingBottomUnit, spacingData.padding.bottom.unit);
		instance._setInput(instance._paddingLeftInt, spacingData.padding.left.value);
		instance._setSelect(instance._paddingLeftUnit, spacingData.padding.left.unit);

		instance._setInput(instance._marginTopInt, spacingData.margin.top.value);
		instance._setSelect(instance._marginTopUnit, spacingData.margin.top.unit);
		instance._setInput(instance._marginRightInt, spacingData.margin.right.value);
		instance._setSelect(instance._marginRightUnit, spacingData.margin.right.unit);
		instance._setInput(instance._marginBottomInt, spacingData.margin.bottom.value);
		instance._setSelect(instance._marginBottomUnit, spacingData.margin.bottom.unit);
		instance._setInput(instance._marginLeftInt, spacingData.margin.left.value);
		instance._setSelect(instance._marginLeftUnit, spacingData.margin.left.unit);

		// Advanced CSS

		var customStyleBlock = jQuery('#lfr-custom-css-block-' + instance._curPortletWrapperId);

		var customStyles = customStyleBlock.html();

		if (customStyles == '' || customStyles == null) {
			customStyles = objData.advancedData.customCSS;
		}

		instance._setTextarea(instance._customCSS, customStyles);
	},

	_setInput: function(obj, value) {
		var instance = this;

		obj.val(value);
	},

	_setSelect: function(obj, value) {
		var instance = this;

		if (value != '') {
			obj.find('option[@value=' + value + ']').attr('selected', 'selected');
		}
	},

	_setTextarea: function(obj, value) {
		var instance = this;

		instance._setInput(obj, value);
	},

	_spacingStyles: function() {
		var instance = this;

		var portlet = instance._curPortlet;

		var ufaPadding = instance._ufaPadding;
		var ufaMargin = instance._ufaMargin;

		var spacingData = instance._objData.spacingData;

		// Padding

		var pTop = instance._paddingTopInt;
		var pTopUnit = instance._paddingTopUnit;
		var pRight = instance._paddingRightInt;
		var pRightUnit = instance._paddingRightUnit;
		var pBottom = instance._paddingBottomInt;
		var pBottomUnit = instance._paddingBottomUnit;
		var pLeft = instance._paddingLeftInt;
		var pLeftUnit = instance._paddingLeftUnit;

		var changePadding = function() {
			var styling = {};

			var padding = instance._getCombo(pTop, pTopUnit);

			styling = {padding: padding.both};

			var ufa = ufaPadding.is(':checked');

			spacingData.padding.top.value = padding.input;
			spacingData.padding.top.unit = padding.selectBox;

			spacingData.padding.sameForAll = ufa;

			if (!ufa) {
				var extStyling = {};

				extStyling.paddingTop = styling.padding;

				var right = instance._getCombo(pRight, pRightUnit);
				var bottom = instance._getCombo(pBottom, pBottomUnit);
				var left = instance._getCombo(pLeft, pLeftUnit);

				extStyling.paddingRight = right.both;
				extStyling.paddingBottom = bottom.both;
				extStyling.paddingLeft = left.both;

				styling = extStyling;

				spacingData.padding.right.value = right.input;
				spacingData.padding.right.unit = right.selectBox;

				spacingData.padding.bottom.value = bottom.input;
				spacingData.padding.bottom.unit = bottom.selectBox;

				spacingData.padding.left.value = left.input;
				spacingData.padding.left.unit = left.selectBox;
			}

			portlet.css(styling);
		};

		pTop.unbind().blur(changePadding);
		pRight.unbind().blur(changePadding);
		pBottom.unbind().blur(changePadding);
		pLeft.unbind().blur(changePadding);

		pTop.unbind().keyup(changePadding);
		pRight.unbind().keyup(changePadding);
		pBottom.unbind().keyup(changePadding);
		pLeft.unbind().keyup(changePadding);

		pTopUnit.unbind().change(changePadding);
		pRightUnit.unbind().change(changePadding);
		pBottomUnit.unbind().change(changePadding);
		pLeftUnit.unbind().change(changePadding);

		ufaPadding.unbind().click(changePadding);

		// Margin

		var mTop = instance._marginTopInt;
		var mTopUnit = instance._marginTopUnit;
		var mRight = instance._marginRightInt;
		var mRightUnit = instance._marginRightUnit;
		var mBottom = instance._marginBottomInt;
		var mBottomUnit = instance._marginBottomUnit;
		var mLeft = instance._marginLeftInt;
		var mLeftUnit = instance._marginLeftUnit;

		var changeMargin = function() {
			var styling = {};

			var margin = instance._getCombo(mTop, mTopUnit);

			styling = {margin: margin.both};

			var ufa = ufaMargin.is(':checked');

			spacingData.margin.top.value = margin.input;
			spacingData.margin.top.unit = margin.selectBox;

			spacingData.margin.sameForAll = ufa;

			if (!ufa) {
				var extStyling = {};

				extStyling.marginTop = styling.margin;

				var right = instance._getCombo(mRight, mRightUnit);
				var bottom = instance._getCombo(mBottom, mBottomUnit);
				var left = instance._getCombo(mLeft, mLeftUnit);

				extStyling.marginRight = right.both;
				extStyling.marginBottom = bottom.both;
				extStyling.marginLeft = left.both;

				styling = extStyling;

				spacingData.margin.right.value = right.input;
				spacingData.margin.right.unit = right.selectBox;

				spacingData.margin.bottom.value = bottom.input;
				spacingData.margin.bottom.unit = bottom.selectBox;

				spacingData.margin.left.value = left.input;
				spacingData.margin.left.unit = left.selectBox;
			}

			portlet.css(styling);
		};

		mTop.unbind().blur(changeMargin);
		mRight.unbind().blur(changeMargin);
		mBottom.unbind().blur(changeMargin);
		mLeft.unbind().blur(changeMargin);

		mTop.unbind().keyup(changeMargin);
		mRight.unbind().keyup(changeMargin);
		mBottom.unbind().keyup(changeMargin);
		mLeft.unbind().keyup(changeMargin);

		mTopUnit.unbind().change(changeMargin);
		mRightUnit.unbind().change(changeMargin);
		mBottomUnit.unbind().change(changeMargin);
		mLeftUnit.unbind().change(changeMargin);

		ufaMargin.unbind().click(changeMargin);
	},

	_textStyles: function() {
		var instance = this;

		var portlet = instance._curPortlet;
		var fontFamily = instance._fontFamily;
		var fontBold = instance._fontWeight;
		var fontItalic = instance._fontStyle;
		var fontSize = instance._fontSize;
		var fontColor = instance._fontColor;
		var textAlign = instance._textAlign;
		var textDecoration = instance._textDecoration;
		var wordSpacing = instance._wordSpacing;
		var leading = instance._leading;
		var tracking = instance._tracking;

		var textData = instance._objData.textData;

		// Font family

		fontFamily.unbind().change(
			function(){
				var fontFamily = this.options[this.selectedIndex].value;

				portlet.css('font-family', fontFamily);

				textData.fontFamily = fontFamily;
			}
		);

		// Font style

		fontBold.unbind().click(
			function(){
			var style = 'normal';
				if (this.checked){
					style = 'bold';
				}

				portlet.css('font-weight', style);

				textData.fontWeight = style;
			}
		);

		fontItalic.unbind().click(
			function(){
				var style = 'normal';

				if (this.checked){
					style = 'italic';
				}

				portlet.css('font-style', style);

				textData.fontStyle = style;
			}
		);

		// Font size

		fontSize.unbind().change(
			function(){
				var fontSize = this.options[this.selectedIndex].value;

				portlet.css('font-size', fontSize);

				textData.fontSize = fontSize;
			}
		);

		// Font color

		var setColor = function(obj){
			var color = obj.value;

			if (color != '') {
				portlet.css('color', color);

				textData.color = color;
			}
		};

		var colorPicker = new Liferay.ColorPicker(
			{
				context: jQuery('#portlet-set-properties')[0],
				item: fontColor[0],
				onChange: function() {
					setColor(fontColor[0]);
				}
			}
		);

		fontColor.unbind().blur(
			function() {
				setColor(this);
			}
		);

		// Text alignment

		textAlign.unbind().change(
			function(){
				var textAlign = this.options[this.selectedIndex].value;

				portlet.css('text-align', textAlign);

				textData.textAlign = textAlign;
			}
		);

		// Text decoration

		textDecoration.unbind().change(
			function(){
				var decoration = this.options[this.selectedIndex].value;

				portlet.css('text-decoration', decoration);

				textData.textDecoration = decoration;
			}
		);

		// Word spacing

		wordSpacing.unbind().change(
			function(){
				var spacing = this.options[this.selectedIndex].value;

				portlet.css('word-spacing', spacing);

				textData.wordSpacing = spacing;
			}
		);

		// Line height

		leading.unbind().change(
			function(){
				var leading = this.options[this.selectedIndex].value;

				portlet.css('line-height', leading);

				textData.lineHeight = leading;
			}
		);

		// Letter spacing

		tracking.unbind().change(
			function(){
				var tracking = this.options[this.selectedIndex].value;

				portlet.css('letter-spacing', tracking);

				textData.letterSpacing = tracking;
			}
		);
	}
};
// file seperator

Liferay.Navigation = new Class({

	/*
	params.layoutIds: an array of displayable layout ids
	params.navBlock: the selector for the navigation block
	*/
	initialize: function(params) {
		var instance = this;

		instance.params = params;

		instance._navBlock = jQuery(instance.params.navBlock);

		instance._isModifiable = instance._navBlock.is('.modify-pages');
		instance._isSortable = instance._navBlock.is('.sort-pages');
		instance._isUseHandle = instance._navBlock.is('.use-handle');

		instance._updateURL = themeDisplay.getPathMain() + '/layout_management/update_page';

		var items = instance._navBlock.find('> ul > li');

		items.each(
			function(i) {
				this._LFR_layoutId = instance.params.layoutIds[i];
			}
		);

		instance._makeAddable();
		instance._makeDeletable();
		instance._makeSortable();
		instance._makeEditable();

		Liferay.Publisher.register('navigation');

		Liferay.Publisher.subscribe('tree', instance._treeCallback, instance);
	},

	_addPage: function(event, obj) {
		var instance = this;

		var navItem = instance._navBlock;
		var addBlock = jQuery('<li>' + instance._enterPage + '</li>');

		var blockInput = addBlock.find('input');

		navItem.find('ul:first').append(addBlock);

		var savePage = addBlock.find('.save-page');
		var cancelPage = addBlock.find('.cancel-page');
		var currentInput = addBlock.find('.enter-page input');

		var pageParents = jQuery(document);

		var pageBlur = function(internalEvent) {
			var currentEl = jQuery(internalEvent.target);
			var liParent = currentEl.parents('ul:eq(0)');

			if ((liParent.length == 0) && !currentEl.is('li') && !currentEl.parents('#add-page').length) {
				cancelPage.trigger('click');
			}
		};

		pageParents.click(pageBlur);

		cancelPage.click(
			function(event) {
				instance._cancelAddingPage(event, addBlock);
				pageParents.unbind('click', pageBlur);
			}
		);

		savePage.click(
			function(event){
				instance._savePage(event, this, instance);
				pageParents.unbind('click', pageBlur);
			}
		);

		currentInput.keyup(
			function(event){
				if (event.keyCode == 13) {
					savePage.trigger('click');
				}
				else if (event.keyCode == 27) {
					cancelPage.trigger('click');
				} else {
					return;
				}

				pageParents.unbind('click', pageBlur);
			}
		);
		blockInput[0].focus();
	},

	_cancelAddingPage: function(event, obj) {
		var instance = this;
		obj.remove();
	},

	_cancelPage: function(event, obj, oldName) {
		var navItem = null;

		if (oldName) {
			navItem = jQuery(obj).parents('li');

			var enterPage = navItem.find('.enter-page');

			enterPage.prev().show();
			enterPage.remove();
		}
		else {
			navItem = jQuery(this).parents('li');

			navItem.remove();
		}
	},

	_deleteButton: function(obj) {
		var instance = this;

		obj.append('<span class="delete-tab">X</span>');

		var deleteTab = obj.find('.delete-tab');

		deleteTab.click(
			function(event) {
				instance._removePage(this, instance);

			}
		);

		deleteTab.hide();

		obj.hover(
			function() {
				jQuery(this).find('.delete-tab').fadeIn('fast');
			},
			function() {
				jQuery(this).find('.delete-tab').fadeOut('fast');
			}
		);
	},

	_makeAddable: function() {
		var instance = this;

		if (instance._isModifiable) {
			var navList = instance._navBlock.find('ul:first');

			instance._enterPage =
				'<div class="enter-page">' +
				'<input type="text" name="new_page" value="" class="text" />' +
				'<a class="cancel-page" href="javascript: ;"></a>' +
				'<a class="save-page" href="javascript: ;">' + Liferay.Language.get('save') + '</a>' +
				'</div>';

			navList.after(
				'<div id="add-page">' +
				'<a href="javascript:;">' +
				'<span>' + Liferay.Language.get('add-page') + '</span>' +
				'</a>' +
				'</div>');

			var addPage = navList.parent().find('#add-page a');

			addPage.click(
				function(event){
					instance._addPage(event, this);
				}
			);
		}
	},

	_makeDeletable: function() {
		var instance = this;

		if (instance._isModifiable) {
			var navItems = instance._navBlock.find('li').not('.selected');

			instance._deleteButton(navItems);
		}
	},

	_makeEditable: function() {
		var instance = this;

		if (instance._isModifiable) {
			var currentItem = instance._navBlock.find('li.selected');
			var currentLink = currentItem.find('a');
			var currentSpan = currentLink.find('span');

			currentLink.click(
				function(event) {
					if (event.shiftKey) {
						return false;
					}
				}
			);

			var resetCursor = function() {
				currentSpan.css('cursor', 'pointer');
			};

			currentLink.hover(
				function(event) {
					if (event.shiftKey) {
						currentSpan.css('cursor', 'text');
					}
				},
				resetCursor
			);

			currentSpan.click(
				function(event) {
					if (!event.shiftKey) {
						return;
					}
					var span = jQuery(this);
					var text = span.text();

					span.parent().hide();
					span.parent().after(instance._enterPage);

					var enterPage = span.parent().next();

					var pageParents = enterPage.parents();

					var enterPageInput = enterPage.find('input');

					var pageBlur = function(event) {
						event.stopPropagation();
						if (!jQuery(this).is('li')) {
							cancelPage.trigger('click');
						}

						return false;
					};

					enterPageInput.val(text);

					enterPageInput.trigger('select');

					var savePage = enterPage.find('.save-page');

					savePage.click(
						function(event) {
							instance._savePage(event, this, instance, text);
							pageParents.unbind('blur', pageBlur);
						}
					);

					var cancelPage = enterPage.find('.cancel-page');

					cancelPage.hide();

					cancelPage.click(
						function(event) {
							instance._cancelPage(event, this, text);
							pageParents.unbind('blur', pageBlur);
						}
					);

					enterPageInput.keyup(
						function(event) {
							if (event.keyCode == 13) {
								savePage.trigger('click');
								pageParents.unbind('blur', pageBlur);
							}
							else if (event.keyCode == 27) {
								cancelPage.trigger('click');
								pageParents.unbind('blur', pageBlur);
							}
						}
					);

					pageParents.click(pageBlur);

					resetCursor();

					return false;
				}
			);
		}
	},

	_makeSortable: function() {
		var instance = this;

		var navBlock = instance._navBlock;
		var navList = navBlock.find('ul:first');

		if (instance._isSortable) {
			var floatStyle = navList.find('> li').css('float');

			var items = navList.find('li');
			var anchors = items.find('a');

			if (instance._isUseHandle) {
				items.append('<span class="sort-handle">+</span>');
			}
			else {
				anchors.css('cursor', 'move');
				anchors.find('span').css('cursor', 'pointer');
			}

			items.addClass('sortable-item');

			instance.sortable = navList.Sortable(
				{
					accept: 'sortable-item',
					helperclass: 'sort-helper',
					activeclass: 'sortableactive',
					hoverclass: 'sortablehover',
					handle: (instance._isUseHandle ? '.sort-handle' : 'a'),
					opacity: 0.8,
					revert:	true,
					floats:	(floatStyle == 'left' || floatStyle == 'right'),
					tolerance: 'pointer',
					snapDistance: 10,
					onStop: function() {
						instance._saveSortables(this);

						Liferay.Publisher.deliver('navigation', this);
					}
				}
			);
		}
	},

	_removePage: function(obj, instance) {
		var tab = jQuery(obj).parents('li');
		var tabText = tab.find('a span').html();

		if (confirm(Liferay.Language.get('are-you-sure-you-want-to-delete-this-page'))) {
			var data = {
				doAsUserId: themeDisplay.getDoAsUserIdEncoded(),
				cmd: 'delete',
				groupId: themeDisplay.getGroupId(),
				privateLayout: themeDisplay.isPrivateLayout(),
				layoutId: tab[0]._LFR_layoutId
			};

			jQuery.ajax(
				{
					data: data,
					success: function() {
						Liferay.Publisher.deliver('navigation', tab, 'delete');

						tab.remove();
					},
					url: instance._updateURL
				}
			);
		}
	},

	_savePage: function(event, obj, instance, oldName) {
		if ((event.type == 'keyup') && (event.keyCode !== 13)) {
			return;
		}

		var data = null;
		var onSuccess = null;

		var newNavItem = jQuery(obj).parents('li');
		var name = newNavItem.find('input').val();
		var enterPage = newNavItem.find('.enter-page');

		if (oldName) {

			// Updating an existing page

			if (name != oldName) {
				data = {
					doAsUserId: themeDisplay.getDoAsUserIdEncoded(),
					cmd: 'name',
					groupId: themeDisplay.getGroupId(),
					privateLayout: themeDisplay.isPrivateLayout(),
					layoutId: themeDisplay.getLayoutId(),
					name: name,
					languageId: themeDisplay.getLanguageId()
				};

				onSuccess = function(data) {
					data = Liferay.Util.toJSONObject(data);

					var currentTab = enterPage.prev();
					var currentSpan = currentTab.find('span');

					currentSpan.text(name);
					currentTab.show();

					enterPage.remove();

					var oldTitle = jQuery(document).attr('title');

					var regex = new RegExp(oldName, 'g');

					newTitle = oldTitle.replace(regex, name);

					jQuery(document).attr('title', newTitle);
				}
			}
			else {

				// The new name is the same as the old one

				var currentTab = enterPage.prev();

				currentTab.show();
				enterPage.remove();

				return false;
			}
		}
		else {

			// Adding a new page

			data = {
				mainPath: themeDisplay.getPathMain(),
				doAsUserId: themeDisplay.getDoAsUserIdEncoded(),
				cmd: 'add',
				groupId: themeDisplay.getGroupId(),
				privateLayout: themeDisplay.isPrivateLayout(),
				parentLayoutId: themeDisplay.getParentLayoutId(),
				name: name
			};

			onSuccess = function(data) {
				data = Liferay.Util.toJSONObject(data);

				var newTab = jQuery('<a href="' + data.url + '"><span>' + name + '</span></a>');

				if (instance._isUseHandle) {
					enterPage.before('<span class="sort-handle">+</span>');
				}
				else {
					newTab.css('cursor', 'move');
				}

				newNavItem[0]._LFR_layoutId = data.layoutId;

				enterPage.before(newTab);
				enterPage.remove();

				instance.sortable.SortableAddItem(newNavItem[0]);
				instance._deleteButton(newNavItem);

				Liferay.Publisher.deliver('navigation', newNavItem);
			}
		}

		jQuery.ajax(
			{
				data: data,
				success: onSuccess,
				url: instance._updateURL
			}
		);
	},

	_saveSortables: function(obj) {
		var instance = this;

		tabs = jQuery('li', instance._navBlock);

		var data = {
			doAsUserId: themeDisplay.getDoAsUserIdEncoded(),
			cmd: 'priority',
			groupId: themeDisplay.getGroupId(),
			privateLayout: themeDisplay.isPrivateLayout(),
			layoutId: obj._LFR_layoutId,
			priority: tabs.index(obj)
		};

		jQuery.ajax(
			{
				data: data,
				url: instance._updateURL
			}
		);
	},

	_treeCallback: function(item, obj) {
		var instance = this;

		var navigation = instance._navBlock.find('> ul');

		if (instance._isSortable) {
			var liItems = navigation.find('> li');

			var droppedItem = jQuery(item);
			var tree = droppedItem.parent();
			var droppedName = droppedItem.find('span:first').text();
			var newParent = jQuery(obj).parents('li:first');

			var liChild = liItems.find('span').not('.delete-tab');

			liChild = liChild.filter(
				function() {
					var currentItem = jQuery(this);

					if (currentItem.text() == droppedName) {
						return true;
					}
					else {
						return false;
					}
				}
			);

			var treeItems = tree.find('> li');

			var newIndex = treeItems.index(item);

			if (liChild.length > 0) {
				var newSibling = liItems.eq(newIndex);
				var parentLi = liChild.parents('li:first');

				if (!newParent.is('.tree-item')) {
					newSibling.after(parentLi);

					if (parentLi.is(':hidden')) {
						parentLi.show();
					}
				}
				else {

					//TODO: add parsing to move child elements around by their layoutId

					parentLi.hide();
				}
			}
			else if (!newParent.is('.tree-item')) {
				var newTab = liItems.lt(1).clone();

				newTab.removeClass('selected');
				newTab.find('.child-menu').remove();

				var newTabLink = newTab.find('a span');

				newTabLink.text(droppedName);
				newTabLink.css('cursor', 'pointer');

				liItems.parent().append(newTab);
			}
		}
	},

	_isSortable: false,
	_isModifiable: false,
	_isUseHandle: false,
	_enterPage: '',
	_updateURL: ''
});
// file seperator

Liferay.Session = {
	autoExtend: false,
	sessionTimeout: 0,
	sessionTimeoutWarning: 0,
	redirectOnExpire: false,

	init: function(params) {
		var instance = this;

		params = params || {};
		instance.autoExtend = params.autoExtend || instance.autoExtend;
		
		instance._timeout = params.timeout || instance.sessionTimeout;
		instance._warning = params.timeoutWarning || instance.sessionTimeoutWarning;
		
		instance.sessionTimeout = instance._timeout * 60000;
		instance.sessionTimeoutWarning = instance._warning * 60000;
		instance._timeoutDiff = instance.sessionTimeout - instance.sessionTimeoutWarning;
		
		instance._currentTime = instance.sessionTimeoutWarning;
		
		instance.redirectOnExpire = params.redirectOnExpire || instance.redirectOnExpire;
		
		instance._cookieKey = 'LFR_SESSION_STATE_' + themeDisplay.getUserId();
		
		instance.banner = new jQuery;
		
		var urlBase = themeDisplay.getPathMain() + '/portal/';
		instance._sessionUrls = {
			expire: urlBase + 'expire_session',
			extend: urlBase + 'extend_session'
		};

		instance._stateCheck = setTimeout(
			function() {
				instance.checkState();	
			},
		instance._timeoutDiff);

		var timeoutMinutes = instance._timeout;
		var timeLeft = instance._warning;
		instance._warningText = Liferay.Language.get('warning-your-session-will-expire', ['[$SPAN$]', timeoutMinutes]);
		instance._warningText = instance._warningText.replace(/\[\$SPAN\$\]/, '<span class="countdown-timer"></span>');
		
		instance._toggleText = {
			hide: Liferay.Language.get('hide'),
			show: Liferay.Language.get('show')
		};
		
		instance._expiredText = Liferay.Language.get('warning-your-session-has-expired');
		instance._extendText = Liferay.Language.get('extend');
		
		instance.setCookie();
	},
	
	checkState: function() {
		var instance = this;
		
		var currentTime = new Date().getTime();
		var sessionState = instance.getCookie();
		var newWaitTime = instance.sessionTimeoutWarning;
		var timeDiff = 0;
		
		clearTimeout(instance._stateCheck);
		if (sessionState == 'expired') {
			instance.expire();
		}
		else {
			timeDiff = currentTime - sessionState;
			
			if (!instance.autoExtend) {
				if ((timeDiff + 100) >= instance.sessionTimeoutWarning) {
						instance.warn();
				}
				else {
					newWaitTime = (instance.sessionTimeoutWarning - timeDiff) + 10000;
					instance._stateCheck = setTimeout(
						function() {
							instance.checkState();	
						},
					newWaitTime);
				}
			}
			else {
				instance.extend();
			}
		}
	},
	
	getCookie: function() {
		var instance = this;
		
		return jQuery.cookie(instance._cookieKey) || 0;
	},
	
	expire: function() {
		var instance = this;

		var banner = instance.banner;
		var warningText = banner.find('#session_warning_text');
		
		document.title = instance._originalTitle;

		if (warningText.length) {
			var sessionHasExpired = instance._expiredText;
			warningText.html(sessionHasExpired);
			
			clearTimeout(instance._sessionExpired);
			
			var okBtn = banner.find('#ok_btn');
			okBtn.click(
				function() {
					instance.notice.close();
					window.location = themeDisplay.getURLHome();
				}
			);

			var cancelBtn = banner.find('#cancel_btn');
			cancelBtn.hide();
			
			jQuery.ajax(
				{
					url: instance._sessionUrls.expire
				}
			);
		}
		instance.setCookie('expired');
		
		if (instance.redirectOnExpire) {
			location.href = themeDisplay.getURLHome();
		}
	},
	
	extend: function() {
		var instance = this;

		if (instance._countdownTimer) {
			clearInterval(instance._countdownTimer);
		}
		jQuery.ajax(
			{
				url: instance._sessionUrls.extend
			}
		);
		document.title = instance._originalTitle;
		
		instance._sessionWarning = setTimeout(
			function() {
				instance.warn();
			}, 
		instance.sessionTimeout);
		
		instance.setCookie();
	},
	
	setCookie: function(status) {
		var instance = this;
		
		var currentTime = new Date().getTime();
		jQuery.cookie(instance._cookieKey, status || currentTime);
	},
	
	warn: function() {
		var instance = this;

		instance.banner = new Liferay.Notice({
			content: instance._warningText,
			closeText: instance._extendText,
			onClose: function() {
				instance.extend();
			},
			toggleText: false
		});

		instance._counter();

		instance._sessionExpired = setTimeout(
			function() {
				instance.expire();
			}, 
		instance.sessionTimeoutWarning);
	},

	_counter: function() {
		var instance = this;
		
		var banner = instance.banner;
		if (banner.length) {
			instance._counterText = banner.find('.countdown-timer');
			instance._originalTitle = document.title;
			var interval = 1000;
			
			instance._counterText.text(instance._setTime());
			document.title = instance.banner.text();
			
			instance._countdownTimer = setInterval(
				function() {
					var time = instance._setTime();
					
					instance._currentTime = instance._currentTime - interval;

					if (instance._currentTime > 0) {
						instance._counterText.text(time);
						document.title = instance.banner.text();
					} else {
						instance.banner.html(instance._expiredText);
						instance.banner.toggleClass('popup-alert-notice').toggleClass('popup-alert-warning');

						if (instance._countdownTimer) {
							clearInterval(instance._countdownTimer);
						}
					}
				},
			interval
			);
		}
	},

	_formatNumber: function(num) {
		var instance = this;
		
		if (!Liferay.Util.isArray(num)) {
			if (num <= 9) {
				num = '0' + num;
			}
		} else {
			num = jQuery.map(num, instance._formatNumber);
		}
		return num;
	},

	_setTime: function() {
		var instance = this;
		
		var amount = instance._currentTime;
		
		if(amount <= 0){
			
		}
		else {
			var days=0, hours=0, minutes=0, seconds=0, output='';
			
			// Remove the milliseconds
			amount = Math.floor(amount/1000); 
			
			hours = Math.floor(amount/3600);
			amount = amount%3600;
	
			minutes = Math.floor(amount/60);
			amount = amount%60;
	
			seconds = Math.floor(amount);
	
			return instance._formatNumber([hours, minutes, seconds]).join(':');
		}
	},

	_banner: [],
	_countdownTimer: null,
	_currentTime: 0,
	_originalTitle: '',
	_sessionUrls: {},
	_sessionWarning: null,
	_sessionExpired: null,
	_timeout: 0,
	_timeoutDiff: 0,
	_warning: 0
};


// file seperator

Liferay.TagsSelector = new Class({

	/*
	params.instanceVar: the instance variable for this class
	params.hiddenInput: the hidden input used to pass in the current tags
	params.textInput: the text input for users to add tags
	params.summarySpan: the summary span tos how the current tags
	params.curTags: comma delimited string of current tags
	params.focus: true if the text input should be focused
	*/
	initialize: function(params) {
		var instance = this;

		instance._curTags = [];

		instance.params = params;

		var hiddenInput = jQuery('#' + params.hiddenInput);

		hiddenInput.attr('name', hiddenInput.attr('id'));

		var textInput = jQuery('#' + params.textInput);
		
		textInput.Autocomplete(
			{
				source: instance._getTags,
				delay: 0,
				fx: {
					type: 'fade',
					duration: 400
				},
				autofill: true,
				dataSourceType: 'json',
				helperClass: 'autocomplete-box',
				selectClass: 'autocomplete-selected',
				minchars: 1,
				onSelect: function(option) {
					textInput.val('');

					var curTags = instance._curTags;
					var selTag = option.text;

					if (curTags.indexOf(selTag) == -1) {
						curTags.push(selTag);
					}

					curTags = curTags.sort();

					instance._update(instance);
				},
				onShow: function() {},
				onHide: function() {}
			}
		);

		if (params.focus) {
			textInput.focus();
		}

		if (params.curTags != '') {
			instance._curTags = params.curTags.split(',');

			instance._update(instance);
		}
	},

	deleteTag: function(instance, id) {
		var params = instance.params;
		var curTags = instance._curTags;

		jQuery('#' + params.instanceVar + 'CurTags' + id).remove();

		curTags.splice(id, 1);

		instance._update(instance);
	},

	_getTags: function(data) {
		return Liferay.Service.Tags.TagsEntry.searchAutocomplete(
			{
				companyId: themeDisplay.getCompanyId(),
				name: "%" + data.value + "%",
				properties: "",
				begin: 0,
				end: 20
			}
		);
	},

	_update: function(instance) {
		instance._updateHiddenInput(instance);
		instance._updateSummarySpan(instance);
	},

	_updateHiddenInput: function(instance) {
		var params = instance.params;
		var curTags = instance._curTags;

		var hiddenInput = jQuery('#' + params.hiddenInput);

		hiddenInput.val(curTags.join(','));
	},

	_updateSummarySpan: function(instance) {
		var params = instance.params;
		var curTags = instance._curTags;

		var html = '';

		jQuery(curTags).each(
			function(i, curTag) {
				html += '<span id="' + params.instanceVar + 'CurTags' + i + '">';
				html += curTag + ' ';
				html += '[<a href="javascript: ' + params.instanceVar + '.deleteTag(' + params.instanceVar + ', ' + i + ');">x</a>]';

				if ((i + 1) < curTags.length) {
					html += ', ';
				}

				html += '</span>';
			}
		);

		var tagsSummary = jQuery('#' + params.summarySpan);

		tagsSummary.html(html);
	}
});



Liferay.GN_KMS_MetaTagsSelector = new Class({

	/*
	params.instanceVar: the instance variable for this class
	params.hiddenInput: the hidden input used to pass in the current tags
	params.textInput: the text input for users to add tags
	params.summarySpan: the summary span tos how the current tags
	params.curTags: comma delimited string of current tags
	params.focus: true if the text input should be focused
	*/
	initialize: function(params) {
		
		var instance = this;
		
		instance._curTags = [];

		instance.params = params;

		var hiddenInput = jQuery('#' + params.hiddenInput);

		hiddenInput.attr('name', hiddenInput.attr('id'));

		var textInput = jQuery('#' + params.textInput);
		
		textInput.Autocomplete(
			{
				source: instance._getTags,
				delay: 0,
				fx: {
					type: 'fade',
					duration: 400
				},
				autofill: true,
				dataSourceType: 'json',
				helperClass: 'autocomplete-box',
				selectClass: 'autocomplete-selected',
				minchars: 1,
				onSelect: function(option) {
					textInput.val('');

					var curTags = instance._curTags;
					var selTag = option.text;

					if (curTags.indexOf(selTag) == -1) {
						curTags.push(selTag);
					}

					curTags = curTags.sort();

					instance._update(instance);
				},
				onShow: function() {},
				onHide: function() {}
			}
		);

		if (params.focus) {
			textInput.focus();
		}

		if (params.curTags != '') {
			instance._curTags = params.curTags.split(',');

			instance._update(instance);
		}
	},

	deleteTag: function(instance, id) {
		var params = instance.params;
		var curTags = instance._curTags;

		jQuery('#' + params.instanceVar + 'CurTags' + id).remove();

		curTags.splice(id, 1);

		instance._update(instance);
	},

	_getTags: function(data) {
	    if (data) {
		return Liferay.Service.Tags.GN_KMS_MetaTagsEntry.searchAutocomplete(
			{
				companyId: themeDisplay.getCompanyId(),
				name: encodeURI(data.value),
				tagGroup: eval("GN_KMS_MetaTagsSelector_"+data.field+"_tagGroup"),
				begin: 0,
				end: 20
			}
			)
		};
	},

	_update: function(instance) {
		instance._updateHiddenInput(instance);
		instance._updateSummarySpan(instance);
	},

	_updateHiddenInput: function(instance) {
		var params = instance.params;
		var curTags = instance._curTags;

		var hiddenInput = jQuery('#' + params.hiddenInput);

		hiddenInput.val(curTags.join(','));
	},

	_updateSummarySpan: function(instance) {
		var params = instance.params;
		var curTags = instance._curTags;

		var html = '';

		jQuery(curTags).each(
			function(i, curTag) {
				html += '<span id="' + params.instanceVar + 'CurTags' + i + '">';
				html += curTag + ' ';
				html += '[<a href="javascript: ' + params.instanceVar + '.deleteTag(' + params.instanceVar + ', ' + i + ');">x</a>]';

				if ((i + 1) < curTags.length) {
					html += ', ';
				}

				html += '</span>';
			}
		);

		var tagsSummary = jQuery('#' + params.summarySpan);

		tagsSummary.html(html);
	}
});



Liferay.GN_KMS_MetaTagsLookupSelector = new Class({

	/*
	params.instanceVar: the instance variable for this class
	params.hiddenInput: the hidden input used to pass in the current tags
	params.textInput: the text input for users to add tags
	params.summarySpan: the summary span tos how the current tags
	params.curTags: comma delimited string of current tags
	params.focus: true if the text input should be focused
	*/
	initialize: function(params) {
		
		var instance = this;
		
		instance._curTags = [];

		instance.params = params;

		var hiddenInput = jQuery('#' + params.hiddenInput);

		hiddenInput.attr('name', hiddenInput.attr('id'));

		var textInput = jQuery('#' + params.textInput);
		
		textInput.Autocomplete(
			{
				source: instance._getTags,
				delay: 0,
				fx: {
					type: 'fade',
					duration: 400
				},
				autofill: true,
				dataSourceType: 'json',
				helperClass: 'autocomplete-box',
				selectClass: 'autocomplete-selected',
				minchars: 1,
				onSelect: function(option) {
					textInput.val('');

					var curTags = instance._curTags;
					var selTag = option.text;

					if (curTags.indexOf(selTag) == -1) {
						curTags.pop();
						curTags.push(selTag);
					}

					curTags = curTags.sort();

					instance._update(instance);
				},
				onShow: function() {},
				onHide: function() {}
			}
		);

		if (params.focus) {
			textInput.focus();
		}

		if (params.curTags != '') {
			instance._curTags = params.curTags.split(',');

			instance._update(instance);
		}
	},

	deleteTag: function(instance, id) {
		var params = instance.params;
		var curTags = instance._curTags;

		jQuery('#' + params.instanceVar + 'CurTags' + id).remove();

		curTags.splice(id, 1);

		instance._update(instance);
	},

	_getTags: function(data) {
	    if (data) {
		return Liferay.Service.Tags.GN_KMS_MetaTagsEntry.lookupAutocomplete(
			{
				companyId: themeDisplay.getCompanyId(),
				name: encodeURI(data.value),
				tagGroup: eval("GN_KMS_MetaTagsLookupSelector_"+data.field+"_table"),
				begin: 0,
				end: 20
			}
			)
		};
	},

	_update: function(instance) {
		instance._updateHiddenInput(instance);
		instance._updateSummarySpan(instance);
	},

	_updateHiddenInput: function(instance) {
		var params = instance.params;
		var curTags = instance._curTags;

		var hiddenInput = jQuery('#' + params.hiddenInput);

		hiddenInput.val(curTags.join(','));
	},

	_updateSummarySpan: function(instance) {
		var params = instance.params;
		var curTags = instance._curTags;

		var html = '';

		jQuery(curTags).each(
			function(i, curTag) {
				html += '<span id="' + params.instanceVar + 'CurTags' + i + '">';
				html += curTag + ' ';
				html += '[<a href="javascript: ' + params.instanceVar + '.deleteTag(' + params.instanceVar + ', ' + i + ');">x</a>]';

				if ((i + 1) < curTags.length) {
					html += ', ';
				}

				html += '</span>';
			}
		);

		var tagsSummary = jQuery('#' + params.summarySpan);

		tagsSummary.html(html);

		var input = jQuery('#' + params.textInput);
		input.toggle();
	}
});

// file seperator

/*  Copyright Mihai Bazon, 2002-2005  |  www.bazon.net/mishoo
 * -----------------------------------------------------------
 *
 * The DHTML Calendar, version 1.0 "It is happening again"
 *
 * Details and latest version at:
 * www.dynarch.com/projects/calendar
 *
 * This script is developed by Dynarch.com.  Visit us at www.dynarch.com.
 *
 * This script is distributed under the GNU Lesser General Public License.
 * Read the entire license text here: http://www.gnu.org/licenses/lgpl.html
 */
 Calendar=function(firstDayOfWeek,dateStr,onSelected,onClose){this.activeDiv=null;this.currentDateEl=null;this.getDateStatus=null;this.getDateToolTip=null;this.getDateText=null;this.timeout=null;this.onSelected=onSelected||null;this.onClose=onClose||null;this.dragging=false;this.hidden=false;this.minYear=1970;this.maxYear=2050;this.dateFormat=Calendar._TT["DEF_DATE_FORMAT"];this.ttDateFormat=Calendar._TT["TT_DATE_FORMAT"];this.isPopup=true;this.weekNumbers=true;if(typeof Calendar._FD=="undefined"){Calendar._FD=0;}this.firstDayOfWeek=typeof firstDayOfWeek=="number"?firstDayOfWeek:Calendar._FD;this.showsOtherMonths=false;this.dateStr=dateStr;this.ar_days=null;this.showsTime=false;this.time24=true;this.yearStep=2;this.hiliteToday=true;this.multiple=null;this.table=null;this.element=null;this.tbody=null;this.firstdayname=null;this.monthsCombo=null;this.yearsCombo=null;this.hilitedMonth=null;this.activeMonth=null;this.hilitedYear=null;this.activeYear=null;this.dateClicked=false;if(typeof Calendar._SDN=="undefined"){if(typeof Calendar._SDN_len=="undefined")Calendar._SDN_len=3;var ar=new Array();for(var i=8;i>0;){ar[--i]=Calendar._DN[i].substr(0,Calendar._SDN_len);}Calendar._SDN=ar;if(typeof Calendar._SMN_len=="undefined")Calendar._SMN_len=3;ar=new Array();for(var i=12;i>0;){ar[--i]=Calendar._MN[i].substr(0,Calendar._SMN_len);}Calendar._SMN=ar;}};Calendar._C=null;Calendar.is_ie=(/msie/i.test(navigator.userAgent)&&!/opera/i.test(navigator.userAgent));Calendar.is_ie5=(Calendar.is_ie&&/msie 5\.0/i.test(navigator.userAgent));Calendar.is_opera=/opera/i.test(navigator.userAgent);Calendar.is_khtml=/Konqueror|Safari|KHTML/i.test(navigator.userAgent);Calendar.getAbsolutePos=function(el){var SL=0,ST=0;var is_div=/^div$/i.test(el.tagName);if(is_div&&el.scrollLeft)SL=el.scrollLeft;if(is_div&&el.scrollTop)ST=el.scrollTop;var r={x:el.offsetLeft-SL,y:el.offsetTop-ST};if(el.offsetParent){var tmp=this.getAbsolutePos(el.offsetParent);r.x+=tmp.x;r.y+=tmp.y;}return r;};Calendar.isRelated=function(el,evt){var related=evt.relatedTarget;if(!related){var type=evt.type;if(type=="mouseover"){related=evt.fromElement;}else if(type=="mouseout"){related=evt.toElement;}}while(related){if(related==el){return true;}related=related.parentNode;}return false;};Calendar.removeClass=function(el,className){if(!(el&&el.className)){return;}var cls=el.className.split(" ");var ar=new Array();for(var i=cls.length;i>0;){if(cls[--i]!=className){ar[ar.length]=cls[i];}}el.className=ar.join(" ");};Calendar.addClass=function(el,className){Calendar.removeClass(el,className);el.className+=" "+className;};Calendar.getElement=function(ev){var f=Calendar.is_ie?window.event.srcElement:ev.currentTarget;while(f.nodeType!=1||/^div$/i.test(f.tagName))f=f.parentNode;return f;};Calendar.getTargetElement=function(ev){var f=Calendar.is_ie?window.event.srcElement:ev.target;while(f.nodeType!=1)f=f.parentNode;return f;};Calendar.stopEvent=function(ev){ev||(ev=window.event);if(Calendar.is_ie){ev.cancelBubble=true;ev.returnValue=false;}else{ev.preventDefault();ev.stopPropagation();}return false;};Calendar.addEvent=function(el,evname,func){if(el.attachEvent){el.attachEvent("on"+evname,func);}else if(el.addEventListener){el.addEventListener(evname,func,true);}else{el["on"+evname]=func;}};Calendar.removeEvent=function(el,evname,func){if(el.detachEvent){el.detachEvent("on"+evname,func);}else if(el.removeEventListener){el.removeEventListener(evname,func,true);}else{el["on"+evname]=null;}};Calendar.createElement=function(type,parent){var el=null;if(document.createElementNS){el=document.createElementNS("http://www.w3.org/1999/xhtml",type);}else{el=document.createElement(type);}if(typeof parent!="undefined"){parent.appendChild(el);}return el;};Calendar._add_evs=function(el){with(Calendar){addEvent(el,"mouseover",dayMouseOver);addEvent(el,"mousedown",dayMouseDown);addEvent(el,"mouseout",dayMouseOut);if(is_ie){addEvent(el,"dblclick",dayMouseDblClick);el.setAttribute("unselectable",true);}}};Calendar.findMonth=function(el){if(typeof el.month!="undefined"){return el;}else if(typeof el.parentNode.month!="undefined"){return el.parentNode;}return null;};Calendar.findYear=function(el){if(typeof el.year!="undefined"){return el;}else if(typeof el.parentNode.year!="undefined"){return el.parentNode;}return null;};Calendar.showMonthsCombo=function(){var cal=Calendar._C;if(!cal){return false;}var cal=cal;var cd=cal.activeDiv;var mc=cal.monthsCombo;if(cal.hilitedMonth){Calendar.removeClass(cal.hilitedMonth,"hilite");}if(cal.activeMonth){Calendar.removeClass(cal.activeMonth,"active");}var mon=cal.monthsCombo.getElementsByTagName("div")[cal.date.getMonth()];Calendar.addClass(mon,"active");cal.activeMonth=mon;var s=mc.style;s.display="block";if(cd.navtype<0)s.left=cd.offsetLeft+"px";else{var mcw=mc.offsetWidth;if(typeof mcw=="undefined")mcw=50;s.left=(cd.offsetLeft+cd.offsetWidth-mcw)+"px";}s.top=(cd.offsetTop+cd.offsetHeight)+"px";};Calendar.showYearsCombo=function(fwd){var cal=Calendar._C;if(!cal){return false;}var cal=cal;var cd=cal.activeDiv;var yc=cal.yearsCombo;if(cal.hilitedYear){Calendar.removeClass(cal.hilitedYear,"hilite");}if(cal.activeYear){Calendar.removeClass(cal.activeYear,"active");}cal.activeYear=null;var Y=cal.date.getFullYear()+(fwd?1:-1);var yr=yc.firstChild;var show=false;for(var i=12;i>0;--i){if(Y>=cal.minYear&&Y<=cal.maxYear){yr.innerHTML=Y;yr.year=Y;yr.style.display="block";show=true;}else{yr.style.display="none";}yr=yr.nextSibling;Y+=fwd?cal.yearStep:-cal.yearStep;}if(show){var s=yc.style;s.display="block";if(cd.navtype<0)s.left=cd.offsetLeft+"px";else{var ycw=yc.offsetWidth;if(typeof ycw=="undefined")ycw=50;s.left=(cd.offsetLeft+cd.offsetWidth-ycw)+"px";}s.top=(cd.offsetTop+cd.offsetHeight)+"px";}};Calendar.tableMouseUp=function(ev){var cal=Calendar._C;if(!cal){return false;}if(cal.timeout){clearTimeout(cal.timeout);}var el=cal.activeDiv;if(!el){return false;}var target=Calendar.getTargetElement(ev);ev||(ev=window.event);Calendar.removeClass(el,"active");if(target==el||target.parentNode==el){Calendar.cellClick(el,ev);}var mon=Calendar.findMonth(target);var date=null;if(mon){date=new Date(cal.date);if(mon.month!=date.getMonth()){date.setMonth(mon.month);cal.setDate(date);cal.dateClicked=false;cal.callHandler();}}else{var year=Calendar.findYear(target);if(year){date=new Date(cal.date);if(year.year!=date.getFullYear()){date.setFullYear(year.year);cal.setDate(date);cal.dateClicked=false;cal.callHandler();}}}with(Calendar){removeEvent(document,"mouseup",tableMouseUp);removeEvent(document,"mouseover",tableMouseOver);removeEvent(document,"mousemove",tableMouseOver);cal._hideCombos();_C=null;return stopEvent(ev);}};Calendar.tableMouseOver=function(ev){var cal=Calendar._C;if(!cal){return;}var el=cal.activeDiv;var target=Calendar.getTargetElement(ev);if(target==el||target.parentNode==el){Calendar.addClass(el,"hilite active");Calendar.addClass(el.parentNode,"rowhilite");}else{if(typeof el.navtype=="undefined"||(el.navtype!=50&&(el.navtype==0||Math.abs(el.navtype)>2)))Calendar.removeClass(el,"active");Calendar.removeClass(el,"hilite");Calendar.removeClass(el.parentNode,"rowhilite");}ev||(ev=window.event);if(el.navtype==50&&target!=el){var pos=Calendar.getAbsolutePos(el);var w=el.offsetWidth;var x=ev.clientX;var dx;var decrease=true;if(x>pos.x+w){dx=x-pos.x-w;decrease=false;}else dx=pos.x-x;if(dx<0)dx=0;var range=el._range;var current=el._current;var count=Math.floor(dx/10)%range.length;for(var i=range.length;--i>=0;)if(range[i]==current)break;while(count-->0)if(decrease){if(--i<0)i=range.length-1;}else if(++i>=range.length)i=0;var newval=range[i];el.innerHTML=newval;cal.onUpdateTime();}var mon=Calendar.findMonth(target);if(mon){if(mon.month!=cal.date.getMonth()){if(cal.hilitedMonth){Calendar.removeClass(cal.hilitedMonth,"hilite");}Calendar.addClass(mon,"hilite");cal.hilitedMonth=mon;}else if(cal.hilitedMonth){Calendar.removeClass(cal.hilitedMonth,"hilite");}}else{if(cal.hilitedMonth){Calendar.removeClass(cal.hilitedMonth,"hilite");}var year=Calendar.findYear(target);if(year){if(year.year!=cal.date.getFullYear()){if(cal.hilitedYear){Calendar.removeClass(cal.hilitedYear,"hilite");}Calendar.addClass(year,"hilite");cal.hilitedYear=year;}else if(cal.hilitedYear){Calendar.removeClass(cal.hilitedYear,"hilite");}}else if(cal.hilitedYear){Calendar.removeClass(cal.hilitedYear,"hilite");}}return Calendar.stopEvent(ev);};Calendar.tableMouseDown=function(ev){if(Calendar.getTargetElement(ev)==Calendar.getElement(ev)){return Calendar.stopEvent(ev);}};Calendar.calDragIt=function(ev){var cal=Calendar._C;if(!(cal&&cal.dragging)){return false;}var posX;var posY;if(Calendar.is_ie){posY=window.event.clientY+document.body.scrollTop;posX=window.event.clientX+document.body.scrollLeft;}else{posX=ev.pageX;posY=ev.pageY;}cal.hideShowCovered();var st=cal.element.style;st.left=(posX-cal.xOffs)+"px";st.top=(posY-cal.yOffs)+"px";return Calendar.stopEvent(ev);};Calendar.calDragEnd=function(ev){var cal=Calendar._C;if(!cal){return false;}cal.dragging=false;with(Calendar){removeEvent(document,"mousemove",calDragIt);removeEvent(document,"mouseup",calDragEnd);tableMouseUp(ev);}cal.hideShowCovered();};Calendar.dayMouseDown=function(ev){var el=Calendar.getElement(ev);if(el.disabled){return false;}var cal=el.calendar;cal.activeDiv=el;Calendar._C=cal;if(el.navtype!=300)with(Calendar){if(el.navtype==50){el._current=el.innerHTML;addEvent(document,"mousemove",tableMouseOver);}else addEvent(document,Calendar.is_ie5?"mousemove":"mouseover",tableMouseOver);addClass(el,"hilite active");addEvent(document,"mouseup",tableMouseUp);}else if(cal.isPopup){cal._dragStart(ev);}if(el.navtype==-1||el.navtype==1){if(cal.timeout)clearTimeout(cal.timeout);cal.timeout=setTimeout("Calendar.showMonthsCombo()",250);}else if(el.navtype==-2||el.navtype==2){if(cal.timeout)clearTimeout(cal.timeout);cal.timeout=setTimeout((el.navtype>0)?"Calendar.showYearsCombo(true)":"Calendar.showYearsCombo(false)",250);}else{cal.timeout=null;}return Calendar.stopEvent(ev);};Calendar.dayMouseDblClick=function(ev){Calendar.cellClick(Calendar.getElement(ev),ev||window.event);if(Calendar.is_ie){document.selection.empty();}};Calendar.dayMouseOver=function(ev){var el=Calendar.getElement(ev);if(Calendar.isRelated(el,ev)||Calendar._C||el.disabled){return false;}if(el.ttip){if(el.ttip.substr(0,1)=="_"){el.ttip=el.caldate.print(el.calendar.ttDateFormat)+el.ttip.substr(1);}el.calendar.tooltips.innerHTML=el.ttip;}if(el.navtype!=300){Calendar.addClass(el,"hilite");if(el.caldate){Calendar.addClass(el.parentNode,"rowhilite");}}return Calendar.stopEvent(ev);};Calendar.dayMouseOut=function(ev){with(Calendar){var el=getElement(ev);if(isRelated(el,ev)||_C||el.disabled)return false;removeClass(el,"hilite");if(el.caldate)removeClass(el.parentNode,"rowhilite");if(el.calendar)el.calendar.tooltips.innerHTML=_TT["SEL_DATE"];return stopEvent(ev);}};Calendar.cellClick=function(el,ev){var cal=el.calendar;var closing=false;var newdate=false;var date=null;if(typeof el.navtype=="undefined"){if(cal.currentDateEl){Calendar.removeClass(cal.currentDateEl,"selected");Calendar.addClass(el,"selected");closing=(cal.currentDateEl==el);if(!closing){cal.currentDateEl=el;}}cal.date.setDateOnly(el.caldate);date=cal.date;var other_month=!(cal.dateClicked=!el.otherMonth);if(!other_month&&!cal.currentDateEl)cal._toggleMultipleDate(new Date(date));else newdate=!el.disabled;if(other_month)cal._init(cal.firstDayOfWeek,date);}else{if(el.navtype==200){Calendar.removeClass(el,"hilite");cal.callCloseHandler();return;}date=new Date(cal.date);if(el.navtype==0)date.setDateOnly(new Date());cal.dateClicked=false;var year=date.getFullYear();var mon=date.getMonth();function setMonth(m){var day=date.getDate();var max=date.getMonthDays(m);if(day>max){date.setDate(max);}date.setMonth(m);};switch(el.navtype){case 400:Calendar.removeClass(el,"hilite");var text=Calendar._TT["ABOUT"];if(typeof text!="undefined"){text+=cal.showsTime?Calendar._TT["ABOUT_TIME"]:"";}else{text="Help and about box text is not translated into this language.\n"+"If you know this language and you feel generous please update\n"+"the corresponding file in \"lang\" subdir to match calendar-en.js\n"+"and send it back to <mihai_bazon@yahoo.com> to get it into the distribution  ;-)\n\n"+"Thank you!\n"+"http://dynarch.com/mishoo/calendar.epl\n";}alert(text);return;case-2:if(year>cal.minYear){date.setFullYear(year-1);}break;case-1:if(mon>0){setMonth(mon-1);}else if(year-->cal.minYear){date.setFullYear(year);setMonth(11);}break;case 1:if(mon<11){setMonth(mon+1);}else if(year<cal.maxYear){date.setFullYear(year+1);setMonth(0);}break;case 2:if(year<cal.maxYear){date.setFullYear(year+1);}break;case 100:cal.setFirstDayOfWeek(el.fdow);return;case 50:var range=el._range;var current=el.innerHTML;for(var i=range.length;--i>=0;)if(range[i]==current)break;if(ev&&ev.shiftKey){if(--i<0)i=range.length-1;}else if(++i>=range.length)i=0;var newval=range[i];el.innerHTML=newval;cal.onUpdateTime();return;case 0:if((typeof cal.getDateStatus=="function")&&cal.getDateStatus(date,date.getFullYear(),date.getMonth(),date.getDate())){return false;}break;}if(!date.equalsTo(cal.date)){cal.setDate(date);newdate=true;}else if(el.navtype==0)newdate=closing=true;}if(newdate){ev&&cal.callHandler();}if(closing){Calendar.removeClass(el,"hilite");ev&&cal.callCloseHandler();}};Calendar.prototype.create=function(_par){var parent=null;if(!_par){parent=document.getElementsByTagName("body")[0];this.isPopup=true;}else{parent=_par;this.isPopup=false;}this.date=this.dateStr?new Date(this.dateStr):new Date();var table=Calendar.createElement("table");this.table=table;table.cellSpacing=0;table.cellPadding=0;table.calendar=this;Calendar.addEvent(table,"mousedown",Calendar.tableMouseDown);var div=Calendar.createElement("div");this.element=div;div.className="calendar";if(this.isPopup){div.style.position="absolute";div.style.display="none";}div.appendChild(table);var thead=Calendar.createElement("thead",table);var cell=null;var row=null;var cal=this;var hh=function(text,cs,navtype){cell=Calendar.createElement("td",row);cell.colSpan=cs;cell.className="button";if(navtype!=0&&Math.abs(navtype)<=2)cell.className+=" nav";Calendar._add_evs(cell);cell.calendar=cal;cell.navtype=navtype;cell.innerHTML="<div unselectable='on'>"+text+"</div>";return cell;};row=Calendar.createElement("tr",thead);var title_length=6;(this.isPopup)&&--title_length;(this.weekNumbers)&&++title_length;hh("?",1,400).ttip=Calendar._TT["INFO"];this.title=hh("",title_length,300);this.title.className="title";if(this.isPopup){this.title.ttip=Calendar._TT["DRAG_TO_MOVE"];this.title.style.cursor="move";hh("&#x00d7;",1,200).ttip=Calendar._TT["CLOSE"];}row=Calendar.createElement("tr",thead);row.className="headrow";this._nav_py=hh("&#x00ab;",1,-2);this._nav_py.ttip=Calendar._TT["PREV_YEAR"];this._nav_pm=hh("&#x2039;",1,-1);this._nav_pm.ttip=Calendar._TT["PREV_MONTH"];this._nav_now=hh(Calendar._TT["TODAY"],this.weekNumbers?4:3,0);this._nav_now.ttip=Calendar._TT["GO_TODAY"];this._nav_nm=hh("&#x203a;",1,1);this._nav_nm.ttip=Calendar._TT["NEXT_MONTH"];this._nav_ny=hh("&#x00bb;",1,2);this._nav_ny.ttip=Calendar._TT["NEXT_YEAR"];row=Calendar.createElement("tr",thead);row.className="daynames";if(this.weekNumbers){cell=Calendar.createElement("td",row);cell.className="name wn";cell.innerHTML=Calendar._TT["WK"];}for(var i=7;i>0;--i){cell=Calendar.createElement("td",row);if(!i){cell.navtype=100;cell.calendar=this;Calendar._add_evs(cell);}}this.firstdayname=(this.weekNumbers)?row.firstChild.nextSibling:row.firstChild;this._displayWeekdays();var tbody=Calendar.createElement("tbody",table);this.tbody=tbody;for(i=6;i>0;--i){row=Calendar.createElement("tr",tbody);if(this.weekNumbers){cell=Calendar.createElement("td",row);}for(var j=7;j>0;--j){cell=Calendar.createElement("td",row);cell.calendar=this;Calendar._add_evs(cell);}}if(this.showsTime){row=Calendar.createElement("tr",tbody);row.className="time";cell=Calendar.createElement("td",row);cell.className="time";cell.colSpan=2;cell.innerHTML=Calendar._TT["TIME"]||"&nbsp;";cell=Calendar.createElement("td",row);cell.className="time";cell.colSpan=this.weekNumbers?4:3;(function(){function makeTimePart(className,init,range_start,range_end){var part=Calendar.createElement("span",cell);part.className=className;part.innerHTML=init;part.calendar=cal;part.ttip=Calendar._TT["TIME_PART"];part.navtype=50;part._range=[];if(typeof range_start!="number")part._range=range_start;else{for(var i=range_start;i<=range_end;++i){var txt;if(i<10&&range_end>=10)txt='0'+i;else txt=''+i;part._range[part._range.length]=txt;}}Calendar._add_evs(part);return part;};var hrs=cal.date.getHours();var mins=cal.date.getMinutes();var t12=!cal.time24;var pm=(hrs>12);if(t12&&pm)hrs-=12;var H=makeTimePart("hour",hrs,t12?1:0,t12?12:23);var span=Calendar.createElement("span",cell);span.innerHTML=":";span.className="colon";var M=makeTimePart("minute",mins,0,59);var AP=null;cell=Calendar.createElement("td",row);cell.className="time";cell.colSpan=2;if(t12)AP=makeTimePart("ampm",pm?"pm":"am",["am","pm"]);else cell.innerHTML="&nbsp;";cal.onSetTime=function(){var pm,hrs=this.date.getHours(),mins=this.date.getMinutes();if(t12){pm=(hrs>=12);if(pm)hrs-=12;if(hrs==0)hrs=12;AP.innerHTML=pm?"pm":"am";}H.innerHTML=(hrs<10)?("0"+hrs):hrs;M.innerHTML=(mins<10)?("0"+mins):mins;};cal.onUpdateTime=function(){var date=this.date;var h=parseInt(H.innerHTML,10);if(t12){if(/pm/i.test(AP.innerHTML)&&h<12)h+=12;else if(/am/i.test(AP.innerHTML)&&h==12)h=0;}var d=date.getDate();var m=date.getMonth();var y=date.getFullYear();date.setHours(h);date.setMinutes(parseInt(M.innerHTML,10));date.setFullYear(y);date.setMonth(m);date.setDate(d);this.dateClicked=false;this.callHandler();};})();}else{this.onSetTime=this.onUpdateTime=function(){};}var tfoot=Calendar.createElement("tfoot",table);row=Calendar.createElement("tr",tfoot);row.className="footrow";cell=hh(Calendar._TT["SEL_DATE"],this.weekNumbers?8:7,300);cell.className="ttip";if(this.isPopup){cell.ttip=Calendar._TT["DRAG_TO_MOVE"];cell.style.cursor="move";}this.tooltips=cell;div=Calendar.createElement("div",this.element);this.monthsCombo=div;div.className="combo";for(i=0;i<Calendar._MN.length;++i){var mn=Calendar.createElement("div");mn.className=Calendar.is_ie?"label-IEfix":"label";mn.month=i;mn.innerHTML=Calendar._SMN[i];div.appendChild(mn);}div=Calendar.createElement("div",this.element);this.yearsCombo=div;div.className="combo";for(i=12;i>0;--i){var yr=Calendar.createElement("div");yr.className=Calendar.is_ie?"label-IEfix":"label";div.appendChild(yr);}this._init(this.firstDayOfWeek,this.date);parent.appendChild(this.element);};Calendar._keyEvent=function(ev){var cal=window._dynarch_popupCalendar;if(!cal||cal.multiple)return false;(Calendar.is_ie)&&(ev=window.event);var act=(Calendar.is_ie||ev.type=="keypress"),K=ev.keyCode;if(ev.ctrlKey){switch(K){case 37:act&&Calendar.cellClick(cal._nav_pm);break;case 38:act&&Calendar.cellClick(cal._nav_py);break;case 39:act&&Calendar.cellClick(cal._nav_nm);break;case 40:act&&Calendar.cellClick(cal._nav_ny);break;default:return false;}}else switch(K){case 32:Calendar.cellClick(cal._nav_now);break;case 27:act&&cal.callCloseHandler();break;case 37:case 38:case 39:case 40:if(act){var prev,x,y,ne,el,step;prev=K==37||K==38;step=(K==37||K==39)?1:7;function setVars(){el=cal.currentDateEl;var p=el.pos;x=p&15;y=p>>4;ne=cal.ar_days[y][x];};setVars();function prevMonth(){var date=new Date(cal.date);date.setDate(date.getDate()-step);cal.setDate(date);};function nextMonth(){var date=new Date(cal.date);date.setDate(date.getDate()+step);cal.setDate(date);};while(1){switch(K){case 37:if(--x>=0)ne=cal.ar_days[y][x];else{x=6;K=38;continue;}break;case 38:if(--y>=0)ne=cal.ar_days[y][x];else{prevMonth();setVars();}break;case 39:if(++x<7)ne=cal.ar_days[y][x];else{x=0;K=40;continue;}break;case 40:if(++y<cal.ar_days.length)ne=cal.ar_days[y][x];else{nextMonth();setVars();}break;}break;}if(ne){if(!ne.disabled)Calendar.cellClick(ne);else if(prev)prevMonth();else nextMonth();}}break;case 13:if(act)Calendar.cellClick(cal.currentDateEl,ev);break;default:return false;}return Calendar.stopEvent(ev);};Calendar.prototype._init=function(firstDayOfWeek,date){var today=new Date(),TY=today.getFullYear(),TM=today.getMonth(),TD=today.getDate();this.table.style.visibility="hidden";var year=date.getFullYear();if(year<this.minYear){year=this.minYear;date.setFullYear(year);}else if(year>this.maxYear){year=this.maxYear;date.setFullYear(year);}this.firstDayOfWeek=firstDayOfWeek;this.date=new Date(date);var month=date.getMonth();var mday=date.getDate();var no_days=date.getMonthDays();date.setDate(1);var day1=(date.getDay()-this.firstDayOfWeek)%7;if(day1<0)day1+=7;date.setDate(-day1);date.setDate(date.getDate()+1);var row=this.tbody.firstChild;var MN=Calendar._SMN[month];var ar_days=this.ar_days=new Array();var weekend=Calendar._TT["WEEKEND"];var dates=this.multiple?(this.datesCells={}):null;for(var i=0;i<6;++i,row=row.nextSibling){var cell=row.firstChild;if(this.weekNumbers){cell.className="day wn";cell.innerHTML=date.getWeekNumber();cell=cell.nextSibling;}row.className="daysrow";var hasdays=false,iday,dpos=ar_days[i]=[];for(var j=0;j<7;++j,cell=cell.nextSibling,date.setDate(iday+1)){iday=date.getDate();var wday=date.getDay();cell.className="day";cell.pos=i<<4|j;dpos[j]=cell;var current_month=(date.getMonth()==month);if(!current_month){if(this.showsOtherMonths){cell.className+=" othermonth";cell.otherMonth=true;}else{cell.className="emptycell";cell.innerHTML="&nbsp;";cell.disabled=true;continue;}}else{cell.otherMonth=false;hasdays=true;}cell.disabled=false;cell.innerHTML=this.getDateText?this.getDateText(date,iday):iday;if(dates)dates[date.print("%Y%m%d")]=cell;if(this.getDateStatus){var status=this.getDateStatus(date,year,month,iday);if(this.getDateToolTip){var toolTip=this.getDateToolTip(date,year,month,iday);if(toolTip)cell.title=toolTip;}if(status===true){cell.className+=" disabled";cell.disabled=true;}else{if(/disabled/i.test(status))cell.disabled=true;cell.className+=" "+status;}}if(!cell.disabled){cell.caldate=new Date(date);cell.ttip="_";if(!this.multiple&&current_month&&iday==mday&&this.hiliteToday){cell.className+=" selected";this.currentDateEl=cell;}if(date.getFullYear()==TY&&date.getMonth()==TM&&iday==TD){cell.className+=" today";cell.ttip+=Calendar._TT["PART_TODAY"];}if(weekend.indexOf(wday.toString())!=-1)cell.className+=cell.otherMonth?" oweekend":" weekend";}}if(!(hasdays||this.showsOtherMonths))row.className="emptyrow";}this.title.innerHTML=Calendar._MN[month]+", "+year;this.onSetTime();this.table.style.visibility="visible";this._initMultipleDates();};Calendar.prototype._initMultipleDates=function(){if(this.multiple){for(var i in this.multiple){var cell=this.datesCells[i];var d=this.multiple[i];if(!d)continue;if(cell)cell.className+=" selected";}}};Calendar.prototype._toggleMultipleDate=function(date){if(this.multiple){var ds=date.print("%Y%m%d");var cell=this.datesCells[ds];if(cell){var d=this.multiple[ds];if(!d){Calendar.addClass(cell,"selected");this.multiple[ds]=date;}else{Calendar.removeClass(cell,"selected");delete this.multiple[ds];}}}};Calendar.prototype.setDateToolTipHandler=function(unaryFunction){this.getDateToolTip=unaryFunction;};Calendar.prototype.setDate=function(date){if(!date.equalsTo(this.date)){this._init(this.firstDayOfWeek,date);}};Calendar.prototype.refresh=function(){this._init(this.firstDayOfWeek,this.date);};Calendar.prototype.setFirstDayOfWeek=function(firstDayOfWeek){this._init(firstDayOfWeek,this.date);this._displayWeekdays();};Calendar.prototype.setDateStatusHandler=Calendar.prototype.setDisabledHandler=function(unaryFunction){this.getDateStatus=unaryFunction;};Calendar.prototype.setRange=function(a,z){this.minYear=a;this.maxYear=z;};Calendar.prototype.callHandler=function(){if(this.onSelected){this.onSelected(this,this.date.print(this.dateFormat));}};Calendar.prototype.callCloseHandler=function(){if(this.onClose){this.onClose(this);}this.hideShowCovered();};Calendar.prototype.destroy=function(){var el=this.element.parentNode;el.removeChild(this.element);Calendar._C=null;window._dynarch_popupCalendar=null;};Calendar.prototype.reparent=function(new_parent){var el=this.element;el.parentNode.removeChild(el);new_parent.appendChild(el);};Calendar._checkCalendar=function(ev){var calendar=window._dynarch_popupCalendar;if(!calendar){return false;}var el=Calendar.is_ie?Calendar.getElement(ev):Calendar.getTargetElement(ev);for(;el!=null&&el!=calendar.element;el=el.parentNode);if(el==null){window._dynarch_popupCalendar.callCloseHandler();return Calendar.stopEvent(ev);}};Calendar.prototype.show=function(){var rows=this.table.getElementsByTagName("tr");for(var i=rows.length;i>0;){var row=rows[--i];Calendar.removeClass(row,"rowhilite");var cells=row.getElementsByTagName("td");for(var j=cells.length;j>0;){var cell=cells[--j];Calendar.removeClass(cell,"hilite");Calendar.removeClass(cell,"active");}}this.element.style.display="block";this.hidden=false;if(this.isPopup){window._dynarch_popupCalendar=this;Calendar.addEvent(document,"keydown",Calendar._keyEvent);Calendar.addEvent(document,"keypress",Calendar._keyEvent);Calendar.addEvent(document,"mousedown",Calendar._checkCalendar);}this.hideShowCovered();};Calendar.prototype.hide=function(){if(this.isPopup){Calendar.removeEvent(document,"keydown",Calendar._keyEvent);Calendar.removeEvent(document,"keypress",Calendar._keyEvent);Calendar.removeEvent(document,"mousedown",Calendar._checkCalendar);}this.element.style.display="none";this.hidden=true;this.hideShowCovered();};Calendar.prototype.showAt=function(x,y){var s=this.element.style;s.left=x+"px";s.top=y+"px";this.show();};Calendar.prototype.showAtElement=function(el,opts){var self=this;var p=Calendar.getAbsolutePos(el);if(!opts||typeof opts!="string"){this.showAt(p.x,p.y+el.offsetHeight);return true;}function fixPosition(box){if(box.x<0)box.x=0;if(box.y<0)box.y=0;var cp=document.createElement("div");var s=cp.style;s.position="absolute";s.right=s.bottom=s.width=s.height="0px";document.body.appendChild(cp);var br=Calendar.getAbsolutePos(cp);document.body.removeChild(cp);if(Calendar.is_ie){br.y += window.scrollY; br.x += window.scrollX;}else{br.y+=window.scrollY;br.x+=window.scrollX;}var tmp=box.x+box.width-br.x;if(tmp>0)box.x-=tmp;tmp=box.y+box.height-br.y;if(tmp>0)box.y-=tmp;};this.element.style.display="block";Calendar.continuation_for_the_fucking_khtml_browser=function(){var w=self.element.offsetWidth;var h=self.element.offsetHeight;self.element.style.display="none";var valign=opts.substr(0,1);var halign="l";if(opts.length>1){halign=opts.substr(1,1);}switch(valign){case "T":p.y-=h;break;case "B":p.y+=el.offsetHeight;break;case "C":p.y+=(el.offsetHeight-h)/2;break;case "t":p.y+=el.offsetHeight-h;break;case "b":break;}switch(halign){case "L":p.x-=w;break;case "R":p.x+=el.offsetWidth;break;case "C":p.x+=(el.offsetWidth-w)/2;break;case "l":p.x+=el.offsetWidth-w;break;case "r":break;}p.width=w;p.height=h+40;self.monthsCombo.style.display="none";fixPosition(p);self.showAt(p.x,p.y);};if(Calendar.is_khtml)setTimeout("Calendar.continuation_for_the_fucking_khtml_browser()",10);else Calendar.continuation_for_the_fucking_khtml_browser();};Calendar.prototype.setDateFormat=function(str){this.dateFormat=str;};Calendar.prototype.setTtDateFormat=function(str){this.ttDateFormat=str;};Calendar.prototype.parseDate=function(str,fmt){if(!fmt)fmt=this.dateFormat;this.setDate(Date.parseDate(str,fmt));};Calendar.prototype.hideShowCovered=function(){if(!Calendar.is_ie&&!Calendar.is_opera)return;function getVisib(obj){var value=obj.style.visibility;if(!value){if(document.defaultView&&typeof(document.defaultView.getComputedStyle)=="function"){if(!Calendar.is_khtml)value=document.defaultView. getComputedStyle(obj,"").getPropertyValue("visibility");else value='';}else if(obj.currentStyle){value=obj.currentStyle.visibility;}else value='';}return value;};var tags=new Array("applet","iframe","select");var el=this.element;var p=Calendar.getAbsolutePos(el);var EX1=p.x;var EX2=el.offsetWidth+EX1;var EY1=p.y;var EY2=el.offsetHeight+EY1;for(var k=tags.length;k>0;){var ar=document.getElementsByTagName(tags[--k]);var cc=null;for(var i=ar.length;i>0;){cc=ar[--i];p=Calendar.getAbsolutePos(cc);var CX1=p.x;var CX2=cc.offsetWidth+CX1;var CY1=p.y;var CY2=cc.offsetHeight+CY1;if(this.hidden||(CX1>EX2)||(CX2<EX1)||(CY1>EY2)||(CY2<EY1)){if(!cc.__msh_save_visibility){cc.__msh_save_visibility=getVisib(cc);}cc.style.visibility=cc.__msh_save_visibility;}else{if(!cc.__msh_save_visibility){cc.__msh_save_visibility=getVisib(cc);}cc.style.visibility="hidden";}}}};Calendar.prototype._displayWeekdays=function(){var fdow=this.firstDayOfWeek;var cell=this.firstdayname;var weekend=Calendar._TT["WEEKEND"];for(var i=0;i<7;++i){cell.className="day name";var realday=(i+fdow)%7;if(i){cell.ttip=Calendar._TT["DAY_FIRST"].replace("%s",Calendar._DN[realday]);cell.navtype=100;cell.calendar=this;cell.fdow=realday;Calendar._add_evs(cell);}if(weekend.indexOf(realday.toString())!=-1){Calendar.addClass(cell,"weekend");}cell.innerHTML=Calendar._SDN[(i+fdow)%7];cell=cell.nextSibling;}};Calendar.prototype._hideCombos=function(){this.monthsCombo.style.display="none";this.yearsCombo.style.display="none";};Calendar.prototype._dragStart=function(ev){if(this.dragging){return;}this.dragging=true;var posX;var posY;if(Calendar.is_ie){posY=window.event.clientY+document.body.scrollTop;posX=window.event.clientX+document.body.scrollLeft;}else{posY=ev.clientY+window.scrollY;posX=ev.clientX+window.scrollX;}var st=this.element.style;this.xOffs=posX-parseInt(st.left);this.yOffs=posY-parseInt(st.top);with(Calendar){addEvent(document,"mousemove",calDragIt);addEvent(document,"mouseup",calDragEnd);}};Date._MD=new Array(31,28,31,30,31,30,31,31,30,31,30,31);Date.SECOND=1000;Date.MINUTE=60*Date.SECOND;Date.HOUR=60*Date.MINUTE;Date.DAY=24*Date.HOUR;Date.WEEK=7*Date.DAY;Date.parseDate=function(str,fmt){var today=new Date();var y=0;var m=-1;var d=0;var a=str.split(/\W+/);var b=fmt.match(/%./g);var i=0,j=0;var hr=0;var min=0;for(i=0;i<a.length;++i){if(!a[i])continue;switch(b[i]){case "%d":case "%e":d=parseInt(a[i],10);break;case "%m":m=parseInt(a[i],10)-1;break;case "%Y":case "%y":y=parseInt(a[i],10);(y<100)&&(y+=(y>29)?1900:2000);break;case "%b":case "%B":for(j=0;j<12;++j){if(Calendar._MN[j].substr(0,a[i].length).toLowerCase()==a[i].toLowerCase()){m=j;break;}}break;case "%H":case "%I":case "%k":case "%l":hr=parseInt(a[i],10);break;case "%P":case "%p":if(/pm/i.test(a[i])&&hr<12)hr+=12;else if(/am/i.test(a[i])&&hr>=12)hr-=12;break;case "%M":min=parseInt(a[i],10);break;}}if(isNaN(y))y=today.getFullYear();if(isNaN(m))m=today.getMonth();if(isNaN(d))d=today.getDate();if(isNaN(hr))hr=today.getHours();if(isNaN(min))min=today.getMinutes();if(y!=0&&m!=-1&&d!=0)return new Date(y,m,d,hr,min,0);y=0;m=-1;d=0;for(i=0;i<a.length;++i){if(a[i].search(/[a-zA-Z]+/)!=-1){var t=-1;for(j=0;j<12;++j){if(Calendar._MN[j].substr(0,a[i].length).toLowerCase()==a[i].toLowerCase()){t=j;break;}}if(t!=-1){if(m!=-1){d=m+1;}m=t;}}else if(parseInt(a[i],10)<=12&&m==-1){m=a[i]-1;}else if(parseInt(a[i],10)>31&&y==0){y=parseInt(a[i],10);(y<100)&&(y+=(y>29)?1900:2000);}else if(d==0){d=a[i];}}if(y==0)y=today.getFullYear();if(m!=-1&&d!=0)return new Date(y,m,d,hr,min,0);return today;};Date.prototype.getMonthDays=function(month){var year=this.getFullYear();if(typeof month=="undefined"){month=this.getMonth();}if(((0==(year%4))&&((0!=(year%100))||(0==(year%400))))&&month==1){return 29;}else{return Date._MD[month];}};Date.prototype.getDayOfYear=function(){var now=new Date(this.getFullYear(),this.getMonth(),this.getDate(),0,0,0);var then=new Date(this.getFullYear(),0,0,0,0,0);var time=now-then;return Math.floor(time/Date.DAY);};Date.prototype.getWeekNumber=function(){var d=new Date(this.getFullYear(),this.getMonth(),this.getDate(),0,0,0);var DoW=d.getDay();d.setDate(d.getDate()-(DoW+6)%7+3);var ms=d.valueOf();d.setMonth(0);d.setDate(4);return Math.round((ms-d.valueOf())/(7*864e5))+1;};Date.prototype.equalsTo=function(date){return((this.getFullYear()==date.getFullYear())&&(this.getMonth()==date.getMonth())&&(this.getDate()==date.getDate())&&(this.getHours()==date.getHours())&&(this.getMinutes()==date.getMinutes()));};Date.prototype.setDateOnly=function(date){var tmp=new Date(date);this.setDate(1);this.setFullYear(tmp.getFullYear());this.setMonth(tmp.getMonth());this.setDate(tmp.getDate());};Date.prototype.print=function(str){var m=this.getMonth();var d=this.getDate();var y=this.getFullYear();var wn=this.getWeekNumber();var w=this.getDay();var s={};var hr=this.getHours();var pm=(hr>=12);var ir=(pm)?(hr-12):hr;var dy=this.getDayOfYear();if(ir==0)ir=12;var min=this.getMinutes();var sec=this.getSeconds();s["%a"]=Calendar._SDN[w];s["%A"]=Calendar._DN[w];s["%b"]=Calendar._SMN[m];s["%B"]=Calendar._MN[m];s["%C"]=1+Math.floor(y/100);s["%d"]=(d<10)?("0"+d):d;s["%e"]=d;s["%H"]=(hr<10)?("0"+hr):hr;s["%I"]=(ir<10)?("0"+ir):ir;s["%j"]=(dy<100)?((dy<10)?("00"+dy):("0"+dy)):dy;s["%k"]=hr;s["%l"]=ir;s["%m"]=(m<9)?("0"+(1+m)):(1+m);s["%M"]=(min<10)?("0"+min):min;s["%n"]="\n";s["%p"]=pm?"PM":"AM";s["%P"]=pm?"pm":"am";s["%s"]=Math.floor(this.getTime()/1000);s["%S"]=(sec<10)?("0"+sec):sec;s["%t"]="\t";s["%U"]=s["%W"]=s["%V"]=(wn<10)?("0"+wn):wn;s["%u"]=w+1;s["%w"]=w;s["%y"]=(''+y).substr(2,2);s["%Y"]=y;s["%%"]="%";var re=/%./g;if(!Calendar.is_ie5&&!Calendar.is_khtml)return str.replace(re,function(par){return s[par]||par;});var a=str.match(re);for(var i=0;i<a.length;i++){var tmp=s[a[i]];if(tmp){re=new RegExp(a[i],'g');str=str.replace(re,tmp);}}return str;};Date.prototype.__msh_oldSetFullYear=Date.prototype.setFullYear;Date.prototype.setFullYear=function(y){var d=new Date(this);d.__msh_oldSetFullYear(y);if(d.getMonth()!=this.getMonth())this.setDate(28);this.__msh_oldSetFullYear(y);};window._dynarch_popupCalendar=null;
// file seperator

/*  Copyright Mihai Bazon, 2002, 2003  |  http://dynarch.com/mishoo/
 * ---------------------------------------------------------------------------
 *
 * The DHTML Calendar
 *
 * Details and latest version at:
 * http://dynarch.com/mishoo/calendar.epl
 *
 * This script is distributed under the GNU Lesser General Public License.
 * Read the entire license text here: http://www.gnu.org/licenses/lgpl.html
 *
 * This file defines helper functions for setting up the calendar.  They are
 * intended to help non-programmers get a working calendar on their site
 * quickly.  This script should not be seen as part of the calendar.  It just
 * shows you what one can do with the calendar, while in the same time
 * providing a quick and simple method for setting it up.  If you need
 * exhaustive customization of the calendar creation process feel free to
 * modify this code to suit your needs (this is recommended and much better
 * than modifying calendar.js itself).
 */
 Calendar.setup=function(params){function param_default(pname,def){if(typeof params[pname]=="undefined"){params[pname]=def;}};param_default("inputField",null);param_default("displayArea",null);param_default("button",null);param_default("eventName","click");param_default("ifFormat","%Y/%m/%d");param_default("daFormat","%Y/%m/%d");param_default("singleClick",true);param_default("disableFunc",null);param_default("dateStatusFunc",params["disableFunc"]);param_default("dateText",null);param_default("firstDay",null);param_default("align","Br");param_default("range",[1900,2999]);param_default("weekNumbers",true);param_default("flat",null);param_default("flatCallback",null);param_default("onSelect",null);param_default("onClose",null);param_default("onUpdate",null);param_default("date",null);param_default("showsTime",false);param_default("timeFormat","24");param_default("electric",true);param_default("step",2);param_default("position",null);param_default("cache",false);param_default("showOthers",false);param_default("multiple",null);var tmp=["inputField","displayArea","button"];for(var i in tmp){if(typeof params[tmp[i]]=="string"){params[tmp[i]]=document.getElementById(params[tmp[i]]);}}if(!(params.flat||params.multiple||params.inputField||params.displayArea||params.button)){alert("Calendar.setup:\n  Nothing to setup (no fields found).  Please check your code");return false;}function onSelect(cal){var p=cal.params;var update=(cal.dateClicked||p.electric);if(update&&p.inputField){p.inputField.value=cal.date.print(p.ifFormat);if(typeof p.inputField.onchange=="function")p.inputField.onchange();}if(update&&p.displayArea)p.displayArea.innerHTML=cal.date.print(p.daFormat);if(update&&typeof p.onUpdate=="function")p.onUpdate(cal);if(update&&p.flat){if(typeof p.flatCallback=="function")p.flatCallback(cal);}if(update&&p.singleClick&&cal.dateClicked)cal.callCloseHandler();};if(params.flat!=null){if(typeof params.flat=="string")params.flat=document.getElementById(params.flat);if(!params.flat){alert("Calendar.setup:\n  Flat specified but can't find parent.");return false;}var cal=new Calendar(params.firstDay,params.date,params.onSelect||onSelect);cal.showsOtherMonths=params.showOthers;cal.showsTime=params.showsTime;cal.time24=(params.timeFormat=="24");cal.params=params;cal.weekNumbers=params.weekNumbers;cal.setRange(params.range[0],params.range[1]);cal.setDateStatusHandler(params.dateStatusFunc);cal.getDateText=params.dateText;if(params.ifFormat){cal.setDateFormat(params.ifFormat);}if(params.inputField&&typeof params.inputField.value=="string"){cal.parseDate(params.inputField.value);}cal.create(params.flat);cal.show();return false;}var triggerEl=params.button||params.displayArea||params.inputField;triggerEl["on"+params.eventName]=function(){var dateEl=params.inputField||params.displayArea;var dateFmt=params.inputField?params.ifFormat:params.daFormat;var mustCreate=false;var cal=window.calendar;if(dateEl)params.date=Date.parseDate(dateEl.value||dateEl.innerHTML,dateFmt);if(!(cal&&params.cache)){window.calendar=cal=new Calendar(params.firstDay,params.date,params.onSelect||onSelect,params.onClose||function(cal){cal.hide();});cal.showsTime=params.showsTime;cal.time24=(params.timeFormat=="24");cal.weekNumbers=params.weekNumbers;mustCreate=true;}else{if(params.date)cal.setDate(params.date);cal.hide();}if(params.multiple){cal.multiple={};for(var i=params.multiple.length;--i>=0;){var d=params.multiple[i];var ds=d.print("%Y%m%d");cal.multiple[ds]=d;}}cal.showsOtherMonths=params.showOthers;cal.yearStep=params.step;cal.setRange(params.range[0],params.range[1]);cal.params=params;cal.setDateStatusHandler(params.dateStatusFunc);cal.getDateText=params.dateText;cal.setDateFormat(dateFmt);if(mustCreate)cal.create();cal.refresh();if(!params.position)cal.showAtElement(params.button||params.displayArea||params.inputField,params.align);else cal.showAt(params.position[0],params.position[1]);return false;};return cal;};
// file seperator

/*
 * Thickbox 3.1 - One Box To Rule Them All.
 * By Cody Lindley (http://www.codylindley.com)
 * Copyright (c) 2007 cody lindley
 * Licensed under the MIT License: http://www.opensource.org/licenses/mit-license.php
*/
		  
var tb_pathToImage = "/html/js/thickbox/loadingAnimation.gif";

/*!!!!!!!!!!!!!!!!! edit below this line at your own risk !!!!!!!!!!!!!!!!!!!!!!!*/

//on page load call tb_init
jQuery(document).ready(function(){   
	tb_init('a.thickbox, area.thickbox, input.thickbox');//pass where to apply thickbox
	imgLoader = new Image();// preload image
	imgLoader.src = tb_pathToImage;
});

//add thickbox to href & area elements that have a class of .thickbox
function tb_init(domChunk){
	jQuery(domChunk).click(function(){
	var t = this.title || this.name || null;
	var a = this.href || this.alt;
	var g = this.rel || false;
	tb_show(t,a,g);
	this.blur();
	return false;
	});
}

function tb_show(caption, url, imageGroup) {//function called when the user clicks on a thickbox link

	try {
		if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
			jQuery("body","html").css({height: "100%", width: "100%"});
			jQuery("html").css("overflow","hidden");
			if (document.getElementById("TB_HideSelect") === null) {//iframe to hide select elements in ie6
				jQuery("body").append("<iframe id='TB_HideSelect'></iframe><div id='TB_overlay'></div><div id='TB_window'></div>");
				jQuery("#TB_overlay").click(tb_remove);
			}
		}else{//all others
			if(document.getElementById("TB_overlay") === null){
				jQuery("body").append("<div id='TB_overlay'></div><div id='TB_window'></div>");
				jQuery("#TB_overlay").click(tb_remove);
			}
		}
		
		if(tb_detectMacXFF()){
			jQuery("#TB_overlay").addClass("TB_overlayMacFFBGHack");//use png overlay so hide flash
		}else{
			jQuery("#TB_overlay").addClass("TB_overlayBG");//use background and opacity
		}
		
		if(caption===null){caption="";}
		jQuery("body").append("<div id='TB_load'><img src='"+imgLoader.src+"' /></div>");//add loader to the page
		jQuery('#TB_load').show();//show loader
		
		var baseURL;
	   if(url.indexOf("?")!==-1){ //ff there is a query string involved
			baseURL = url.substr(0, url.indexOf("?"));
	   }else{ 
	   		baseURL = url;
	   }
	   
	   var urlString = /\.jpg$|\.jpeg$|\.png$|\.gif$|\.bmp$/;
	   var urlType = baseURL.toLowerCase().match(urlString);

		if(baseURL.match('image_gallery') || urlType == '.jpg' || urlType == '.jpeg' || urlType == '.png' || urlType == '.gif' || urlType == '.bmp'){//code to show images
				
			TB_PrevCaption = "";
			TB_PrevURL = "";
			TB_PrevHTML = "";
			TB_NextCaption = "";
			TB_NextURL = "";
			TB_NextHTML = "";
			TB_imageCount = "";
			TB_FoundURL = false;
			if(imageGroup){
				TB_TempArray = jQuery("a[rel="+imageGroup+"]").get();
				for (TB_Counter = 0; ((TB_Counter < TB_TempArray.length) && (TB_NextHTML === "")); TB_Counter++) {
					var urlTypeTemp = TB_TempArray[TB_Counter].href.toLowerCase().match(urlString);
						if (!(TB_TempArray[TB_Counter].href == url)) {						
							if (TB_FoundURL) {
								TB_NextCaption = TB_TempArray[TB_Counter].title;
								TB_NextURL = TB_TempArray[TB_Counter].href;
								TB_NextHTML = "<span id='TB_next'>&nbsp;&nbsp;<a href='#'>Next &gt;</a></span>";
							} else {
								TB_PrevCaption = TB_TempArray[TB_Counter].title;
								TB_PrevURL = TB_TempArray[TB_Counter].href;
								TB_PrevHTML = "<span id='TB_prev'>&nbsp;&nbsp;<a href='#'>&lt; Prev</a></span>";
							}
						} else {
							TB_FoundURL = true;
							TB_imageCount = "Image " + (TB_Counter + 1) +" of "+ (TB_TempArray.length);											
						}
				}
			}

			imgPreloader = new Image();
			imgPreloader.onload = function(){		
			imgPreloader.onload = null;
				
			// Resizing large images - orginal by Christian Montoya edited by me.
			var pagesize = tb_getPageSize();
			var x = pagesize[0] - 150;
			var y = pagesize[1] - 150;
			var imageWidth = imgPreloader.width;
			var imageHeight = imgPreloader.height;
			if (imageWidth > x) {
				imageHeight = imageHeight * (x / imageWidth); 
				imageWidth = x; 
				if (imageHeight > y) { 
					imageWidth = imageWidth * (y / imageHeight); 
					imageHeight = y; 
				}
			} else if (imageHeight > y) { 
				imageWidth = imageWidth * (y / imageHeight); 
				imageHeight = y; 
				if (imageWidth > x) { 
					imageHeight = imageHeight * (x / imageWidth); 
					imageWidth = x;
				}
			}
			// End Resizing
			
			TB_WIDTH = imageWidth + 30;
			TB_HEIGHT = imageHeight + 60;
			jQuery("#TB_window").append("<a href='' id='TB_ImageOff' title='Close'><img id='TB_Image' src='"+url+"' width='"+imageWidth+"' height='"+imageHeight+"' alt='"+caption+"'/></a>" + "<div id='TB_caption'>"+caption+"<div id='TB_secondLine'>" + TB_imageCount + TB_PrevHTML + TB_NextHTML + "</div></div><div id='TB_closeWindow'><a href='#' id='TB_closeWindowButton' title='Close'>close</a> or Esc Key</div>"); 		
			
			jQuery("#TB_closeWindowButton").click(tb_remove);
			
			if (!(TB_PrevHTML === "")) {
				function goPrev(){
					if(jQuery(document).unbind("click",goPrev)){jQuery(document).unbind("click",goPrev);}
					jQuery("#TB_window").remove();
					jQuery("body").append("<div id='TB_window'></div>");
					tb_show(TB_PrevCaption, TB_PrevURL, imageGroup);
					return false;	
				}
				jQuery("#TB_prev").click(goPrev);
			}
			
			if (!(TB_NextHTML === "")) {		
				function goNext(){
					jQuery("#TB_window").remove();
					jQuery("body").append("<div id='TB_window'></div>");
					tb_show(TB_NextCaption, TB_NextURL, imageGroup);				
					return false;	
				}
				jQuery("#TB_next").click(goNext);
				
			}

			document.onkeydown = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					tb_remove();
				} else if(keycode == 190){ // display previous image
					if(!(TB_NextHTML == "")){
						document.onkeydown = "";
						goNext();
					}
				} else if(keycode == 188){ // display next image
					if(!(TB_PrevHTML == "")){
						document.onkeydown = "";
						goPrev();
					}
				}	
			};
			
			tb_position();
			jQuery("#TB_load").remove();
			jQuery("#TB_ImageOff").click(tb_remove);
			jQuery("#TB_window").css({display:"block"}); //for safari using css instead of show
			};
			
			imgPreloader.src = url;
		}else{//code to show html
			
			var queryString = url.replace(/^[^\?]+\??/,'');
			var params = tb_parseQuery( queryString );

			TB_WIDTH = (params['width']*1) + 30 || 630; //defaults to 630 if no paramaters were added to URL
			TB_HEIGHT = (params['height']*1) + 40 || 440; //defaults to 440 if no paramaters were added to URL
			ajaxContentW = TB_WIDTH - 30;
			ajaxContentH = TB_HEIGHT - 45;
			
			if(url.indexOf('TB_iframe') != -1){// either iframe or ajax window		
					urlNoQuery = url.split('TB_');
					jQuery("#TB_iframeContent").remove();
					if(params['modal'] != "true"){//iframe no modal
						jQuery("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton' title='Close'>close</a> or Esc Key</div></div><iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContentW + 29)+"px;height:"+(ajaxContentH + 17)+"px;' > </iframe>");
					}else{//iframe modal
					jQuery("#TB_overlay").unbind();
						jQuery("#TB_window").append("<iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContentW + 29)+"px;height:"+(ajaxContentH + 17)+"px;'> </iframe>");
					}
			}else{// not an iframe, ajax
					if(jQuery("#TB_window").css("display") != "block"){
						if(params['modal'] != "true"){//ajax no modal
						jQuery("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton'>close</a> or Esc Key</div></div><div id='TB_ajaxContent' style='width:"+ajaxContentW+"px;height:"+ajaxContentH+"px'></div>");
						}else{//ajax modal
						jQuery("#TB_overlay").unbind();
						jQuery("#TB_window").append("<div id='TB_ajaxContent' class='TB_modal' style='width:"+ajaxContentW+"px;height:"+ajaxContentH+"px;'></div>");	
						}
					}else{//this means the window is already up, we are just loading new content via ajax
						jQuery("#TB_ajaxContent")[0].style.width = ajaxContentW +"px";
						jQuery("#TB_ajaxContent")[0].style.height = ajaxContentH +"px";
						jQuery("#TB_ajaxContent")[0].scrollTop = 0;
						jQuery("#TB_ajaxWindowTitle").html(caption);
					}
			}
					
			jQuery("#TB_closeWindowButton").click(tb_remove);
			
				if(url.indexOf('TB_inline') != -1){	
					jQuery("#TB_ajaxContent").append(jQuery('#' + params['inlineId']).children());
					jQuery("#TB_window").unload(function () {
						jQuery('#' + params['inlineId']).append( jQuery("#TB_ajaxContent").children() ); // move elements back when you're finished
					});
					tb_position();
					jQuery("#TB_load").remove();
					jQuery("#TB_window").css({display:"block"}); 
				}else if(url.indexOf('TB_iframe') != -1){
					tb_position();
					if($.browser.safari){//safari needs help because it will not fire iframe onload
						jQuery("#TB_load").remove();
						jQuery("#TB_window").css({display:"block"});
					}
				}else{
					jQuery("#TB_ajaxContent").load(url += "&random=" + (new Date().getTime()),function(){//to do a post change this load method
						tb_position();
						jQuery("#TB_load").remove();
						tb_init("#TB_ajaxContent a.thickbox");
						jQuery("#TB_window").css({display:"block"});
					});
				}
			
		}

		if(!params['modal']){
			document.onkeyup = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					tb_remove();
				}	
			};
		}
		
	} catch(e) {
		//nothing here
	}
}

//helper functions below
function tb_showIframe(){
	jQuery("#TB_load").remove();
	jQuery("#TB_window").css({display:"block"});
}

function tb_remove() {
 	jQuery("#TB_imageOff").unbind("click");
	jQuery("#TB_closeWindowButton").unbind("click");
	jQuery("#TB_window").fadeOut("fast",function(){jQuery('#TB_window,#TB_overlay,#TB_HideSelect').trigger("unload").unbind().remove();});
	jQuery("#TB_load").remove();
	if (typeof document.body.style.maxHeight == "undefined") {//if IE 6
		jQuery("body","html").css({height: "auto", width: "auto"});
		jQuery("html").css("overflow","");
	}
	document.onkeydown = "";
	document.onkeyup = "";
	return false;
}

function tb_position() {
jQuery("#TB_window").css({marginLeft: '-' + parseInt((TB_WIDTH / 2),10) + 'px', width: TB_WIDTH + 'px'});
	if ( !(jQuery.browser.msie && jQuery.browser.version < 7)) { // take away IE6
		jQuery("#TB_window").css({marginTop: '-' + parseInt((TB_HEIGHT / 2),10) + 'px'});
	}
}

function tb_parseQuery ( query ) {
   var Params = {};
   if ( ! query ) {return Params;}// return empty object
   var Pairs = query.split(/[;&]/);
   for ( var i = 0; i < Pairs.length; i++ ) {
      var KeyVal = Pairs[i].split('=');
      if ( ! KeyVal || KeyVal.length != 2 ) {continue;}
      var key = unescape( KeyVal[0] );
      var val = unescape( KeyVal[1] );
      val = val.replace(/\+/g, ' ');
      Params[key] = val;
   }
   return Params;
}

function tb_getPageSize(){
	var de = document.documentElement;
	var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
	var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
	arrayPageSize = [w,h];
	return arrayPageSize;
}

function tb_detectMacXFF() {
  var userAgent = navigator.userAgent.toLowerCase();
  if (userAgent.indexOf('mac') != -1 && userAgent.indexOf('firefox')!=-1) {
    return true;
  }
}



// file seperator

