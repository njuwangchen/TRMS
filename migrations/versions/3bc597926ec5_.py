"""empty message

Revision ID: 3bc597926ec5
Revises: 3a0598059847
Create Date: 2015-03-26 14:46:50.685312

"""

# revision identifiers, used by Alembic.
revision = '3bc597926ec5'
down_revision = '3a0598059847'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.execute("ALTER TABLE code_literature ADD id INT PRIMARY KEY AUTO_INCREMENT;")

def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('code_literature', 'id')
    ### end Alembic commands ###
