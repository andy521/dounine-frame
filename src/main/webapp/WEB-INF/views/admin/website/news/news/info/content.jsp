<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/website/news/news/info/Info.js" type="text/javascript" charset="utf-8"></script>
<div class="easyui-layout" style="height:100%;border-top:none;">
	<div region='center' id="newsCenter" style="border-top:none;">
		<div class="nav-settab">
			<span class="nav-tab-one"></span> 
			<span class="nav-tabs">
				<a href="javascript:void(0);" onclick="return_bug_list();">新闻列表</a> | <a href="javascript:void(0);" class="nav-tabs-select">发布新闻</a> </span> 
			<span class="nav-tab-two"></span>
		</div>
	
		<form id="news_form" method="post">
			<table class="easyui-grid">
				<tr>
					<td colspan="2" style="border-left:none;text-align:left;font-size:14px;border-top:none;height:40px;"><b>发布新的新闻</b></td>
				</tr>
				<tr>
					<td style="border-left:none;text-align:left;" colspan="2">
						<div class="publish_c" style="width:98%;margin:auto;">
							<li>
								<span style="float:left;">
									<input type="hidden" name="id" />
									<input type="text" required="true" class="easyui-textbox" name="title" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">标题：必填</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" class="easyui-textbox" name="keywords" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">关键字：用于搜索引擎SEO优化所用.</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" class="easyui-textbox" name="description" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">描述：用于搜索引擎SEO优化所用.</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" required="true" data-options="min:0,value:0,editable:false" class="easyui-numberspinner" name="sequence" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">排序：值越高,排名显示越靠前,默认时间排序.</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" id="newsClass" name="newsClass.id" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">版块：必选</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<p style="height:30px;line-height:30px;">内容</p>
								<script id="newsContent" type="text/plain" name="content" style="width:100%;"></script>
								<a href="javascript:void(0);" iconCls="icon-d-save" id="NewsButton" onclick="$Info.save($News);" style="float:right;margin-top:10px;background:green;color:white;" class="easyui-linkbutton">&nbsp;&nbsp;发&nbsp;&nbsp;布&nbsp;&nbsp;</a>
							</li>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
	
<script>
function delete_文章管理(){//命名规则  delete_(+)所在tab名称
}
var $Info = new Info();
$Info.form = $("#news_form");
$Info.type = $("#newsClass");

$Info.addUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/add.action" />'+_userUrl;//添加
$Info.editUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/edit.action" />'+_userUrl;//编辑
$Info.newsClassUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/all.action" />'+_userUrl;//列表
$Info.findUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/find.action" />'+_userUrl;

$Info.load($News);
$(function(){
	setTimeout(function(){//为了能获取到高度
		$("#newsContent").height($("#newsCenter").height()-($("#newsCenter").height()/2.4));
		var content = (new UE.ui.Editor());
		content.render('newsContent');
		if(!$News.button){
			content.addListener('ready', function( editor ) {
					$.post($Info.findUrl,{'id':$News.row.id},function(data){
						content.execCommand('clearDocs');
						content.execCommand('insertHtml', data.content);
					});
			 } );
		}
	});
});

var _tab_operator_url = '${base}/admin/website/news/news/content.html'+userUrl;
function return_bug_list(){
	var select_tab = $('#lox-tabs').tabs('getSelected');
	$(select_tab).attr("lox-data-options","href:'"+_tab_operator_url+"'").css('style','hidden');
	$('#lox-tabs').tabs('update',{
		tab:select_tab,
		title:'文章管理',
		options:{
			href:_tab_operator_url,
			method:'post'
		}
	});
}
</script>
