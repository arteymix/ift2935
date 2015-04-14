-- article sur des séries
select distinct noArticle from AProposDe
	where noVideo in (select id from Serie)
