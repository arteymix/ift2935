---article sur des series
Select distinct noArticle from AProposDe
	where noVideo in (Select id from Serie)
