user = courseware.user
course = courseware.course

json.avatarTiny avatar_url(user,:small30)
json.selectedBoardIds []
json.boardId 1481195
json.isSurprise false
json.sharePicId 159510
json.shareTitle courseware.title
json.commentCount 0
json.reshareCount 0
json.id courseware.id
json.path courseware_path(courseware)
json.title courseware.title
json.boardPicId 825398
json.price courseware.topic
json.price_slug Topic.get_id(courseware.topic)
json.isOriginal true
json.nickName user.name
json.userId user.id
json.avatars Hash[]
json.certifyType 2
json.boardName course.name
json.comments []
json.boardUserId 251621
json.mediumZoom asset_url(courseware.pinpic)
