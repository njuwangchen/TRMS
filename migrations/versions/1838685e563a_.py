"""empty message

Revision ID: 1838685e563a
Revises: 18deab09869a
Create Date: 2015-03-26 14:15:37.579720

"""

# revision identifiers, used by Alembic.
revision = '1838685e563a'
down_revision = '18deab09869a'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('code_literature', sa.Column('id', sa.Integer(), nullable=False))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('code_literature', 'id')
    ### end Alembic commands ###